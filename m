Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2F3F99C6B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 22:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1562010E0A5;
	Fri, 17 Apr 2026 22:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hS0rU3AF";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA89110E0A5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 22:08:04 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8a093c784b0so15827196d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776463684; cv=none;
 d=google.com; s=arc-20240605;
 b=JOfsakaGECR+tJeTMGcACzYPMbfA+j+yrgRDwDJ0U8WwmbxT5THR1SE5F4/b43zME5
 ypLPqF1XTsRmdWsYgcJNI9Nbam45wPJeSrelZ6ZaMYrsn592puKqO4xQHur2mu0ydSI9
 1TuQraIXuhm3UZNhy0UY+irqpzQRX7vNnejKnIqtM7Zrv8u2UgzuGDbB2zj+ypVVWBZz
 Sg5y54kiWn+S8n+TFYJz+WLfgtqN3IwbHg1MGZ6ndpkQ1yIJWWO0OEZ7QjiopHIvJzjv
 eLbaCuHpHqeFeuXy3meiQmtPU7y9YjWRNN6XoMqRvr75gNiH5l7aLPC+9x1PmgW9BBoj
 c2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=suo4TyFGqn6eoxSjis73Jd+RG5ilDEkjyrKfJm5ZQP4=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=W7RCPAwuBajA03/8f6g3CoKMqFObOZE6/O1smCzwfeLweDqgGjWeBIPMea6a7vA20M
 UFRwgCF/749/pubxDHLNljx6aG0EF2doxsaZePRERDuXH9HFgwJ3VkU9t3DkPXbj/vCC
 591fundSm6etn78M+qHshm4H0xKFOKdYTfBSaZJUXKC8B9FS7nstEFt2sLmsIsn+hMVS
 BpBNSqGDM6RLAkI1OJPboL0h3x+MR4S5Q6Picy8WCSQ1T50+UkvLUILCRbE2Rh91um45
 EbCp6VnNWABNbkfVfQ8BJdh2Dw2LnhgsFk10Wp3PfB0HSqJGW2npTtk3sTin9+Ql2Gdx
 qFRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776463684; x=1777068484; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=suo4TyFGqn6eoxSjis73Jd+RG5ilDEkjyrKfJm5ZQP4=;
 b=hS0rU3AFM7L2QiQpewyrK3lZf7kfOT2rk5D58D5PSRTvlnuXe3nAdGbqXCq5IsJert
 3wfHRP+L8xfgoiQq/v+K4XNCHd+0bNEzBoNR578LbvnrecpWevxOZcAMOgK+dqN5Z8FN
 XYDlf996qATNfaFRIdQ/9CEFmiT4fqs6rdFhp4pBVBG1OsUAWFIvtjsT/mAGHj/pwluh
 dKx17/7MQslhbxM8ylWMhtalDzBSmBY3McG/kdI+JC99ZVcf1TPx6Rg9IXZdpaTvjNKB
 T9Kt5t5QQ4/5nw5hvofWjoGncU29V9OGlA96e7l8/S60uqJ2N7ccQUB4ViRlRoIfjme+
 1ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776463684; x=1777068484;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=suo4TyFGqn6eoxSjis73Jd+RG5ilDEkjyrKfJm5ZQP4=;
 b=p7e3rub/K9xM5Ux4g/pj1kvIWdCXyJ9NGpiABZul5/s9UBF2muttBzoIHEViU+AEer
 pv1Ys/5mjMZusPTrdwzrNo5ZexV29h2EEw0TOkQg8PfJzX92X2SZB+XIrgI1w8yUgdQJ
 xJ7DE1VDnb70LVtvlAId8Kz0B5Xzs1hUnYyJal1Gov/3EbCvT4fq5ve5vL4ihktwQx7X
 jQXhNfOeXT6Q9g2gTRevZu2eWf9PvqTbrpEnW0Er2jGj5wlALua+8QBmCGdmZ6Z4KBUm
 /gvSVGrX3KPdMjm5K6cYoF6N2nkPXUnkwGXWXmSTlTRFyt1tiewe2VT9Rqe6f6I4XmuV
 r7KA==
X-Gm-Message-State: AOJu0YxjR4hhynp4L59MWGYcrR9muCjPj/20htehnpdiRq0lA37LkANh
 4arfajftGrIJQ6g3y7HDCsO6Hx0kngeRltZklwiUOvzSt/H9Piysho1TV5XDlwaiV0L9z2tl5Ec
 2IVmANiCE2oNBl6KlVR3pqCIYiq8OdEY=
X-Gm-Gg: AeBDietZBNSQvsP2sfjdpyZR28gk2jwY3fTnKSjah7iVMMxOsTOMkl2Z//wXqjChu8+
 4c/TiI2hjGRCM27At++UVyWhFPAEqUxheI5kuUOHNThZfB5tQkfBJxYyhngl+CiqF1JcnYNMqQu
 ak5/HId8qvxNU0ipdlHY09HC2Z0HsQKmn5U/82rtKMY2eRTUBQ0Q3gKBq2fNQiczlNeB0VRuhOF
 TktCMjhDnyX9wmisvpAZ3ScrPPnf5zsoLtfLELicFipvWwtSphcNauhfB1ScRVflyuRDU4FEk98
 j7h3HkuOC8kA6Y+KK34tSphOsVWU/yh9EnPGpGzriDHBdEz1JTslT2nMQPm/AVx02DT311Tp95a
 g7w==
X-Received: by 2002:a05:6214:590b:b0:8a5:104b:e385 with SMTP id
 6a1803df08f44-8b0281342b6mr77879216d6.35.1776463683732; Fri, 17 Apr 2026
 15:08:03 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 18 Apr 2026 08:07:52 +1000
X-Gm-Features: AQROBzB5KE-Rnx0Bb5unzebgrjNJhRFyFDprrLcSdJc2d0gv1hdu018sfNe8BNo
Message-ID: <CAPM=9ty+EifnaAF6xXLFChpc+5hZWUZJdR8zy=arPjrwjirf6Q@mail.gmail.com>
Subject: [git pull] drm for v7.1-rc1 (part two)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Linus.

This is a followup pull which is mostly next material with some fixes.

Alex pointed out I missed one of his AMD MRs from last week, so I
added that, then Jani sent the pipe reordering stuff, otherwise it's
just some minor i915 fixes and a dma-buf fix.

Regards,
Dave

drm-fixes-2026-04-18:
drm for 7.1-rc1 (part 2)

drm:
- Add support for AMD VSDB parsing to drm_edid

dma-buf:
- fix documentation formatting

i915:
- add support for reordered pipes to support joined pipes better
- Fix VESA backlight possible check condition
- Verify the correct plane DDB entry

amdgpu:
- Audio regression fix
- Use drm edid parser for AMD VSDB
- Misc cleanups
- VCE cs parse fixes
- VCN cs parse fixes
- RAS fixes
- Clean up and unify vram reservation handling
- GPU Partition updates
- system_wq cleanups
- Add CONFIG_GCOV_PROFILE_AMDGPU kconfig option
- SMU vram copy updates
- SMU 13/14/15 fixes
- UserQ fixes
- Replace pasid idr with an xarray
- Dither handling fix
- Enable amdgpu by default for CIK APUs
- Add IBs to devcoredump

amdkfd:
- system_wq cleanups

radeon:
- system_wq cleanups
The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-18

for you to fetch changes up to 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

----------------------------------------------------------------
drm for 7.1-rc1 (part 2)

drm:
- Add support for AMD VSDB parsing to drm_edid

dma-buf:
- fix documentation formatting

i915:
- add support for reordered pipes to support joined pipes better
- Fix VESA backlight possible check condition
- Verify the correct plane DDB entry

amdgpu:
- Audio regression fix
- Use drm edid parser for AMD VSDB
- Misc cleanups
- VCE cs parse fixes
- VCN cs parse fixes
- RAS fixes
- Clean up and unify vram reservation handling
- GPU Partition updates
- system_wq cleanups
- Add CONFIG_GCOV_PROFILE_AMDGPU kconfig option
- SMU vram copy updates
- SMU 13/14/15 fixes
- UserQ fixes
- Replace pasid idr with an xarray
- Dither handling fix
- Enable amdgpu by default for CIK APUs
- Add IBs to devcoredump

amdkfd:
- system_wq cleanups

radeon:
- system_wq cleanups

----------------------------------------------------------------
