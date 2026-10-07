Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E21CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D055910E38F;
	Wed,  7 Oct 2026 01:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N8kurpoV";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCBA10E38F
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:18:23 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-66c9995ca60so1625009d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791335902; cv=none;
 d=google.com; s=arc-20260327;
 b=nlaY4AOkOYcgXCgF/qW/JEAIcCGBpb/PyDAeVs5LH3HS+PPlBxJxNyhF6FKmiTJ/47
 R5xLVX4Jjn+pCfKuqtInBP0ELWcO6DADn567Y83JoHbF+vrMaxRhaTKvwhh47WaQ+DgD
 85Fwvn9DmmJ6azu+kTW5kfOZIMohjguTy/HqL9AR5KaXcWnTQQY/46pVDen/tisUrJrv
 RqF8NeZ520h9N4ctcrCCOp9Y9Uj6HQu0qZ11XLZtmMq0aR9zTIaVPLqNBJqHbgHVBzF3
 SQ0teV25PJMNLaYnR9C/Ii9uMW5qm9uYXMQNMNoQ3nMRGs7zXC3ZNFiYK5Lm5FGrHINQ
 BAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pZUZVw/r7QKqfHaSqiu3U/sawF5KkSgPe+LInuVqhTs=;
 fh=XQvtPSlw9ZWnD0Pe9uapMnOMPJRuMFiPCsvEpoldD1o=;
 b=ZtB0JdXDBmxQ6QOpv/7aY2PR2T5XIUtc+QHwvbkFp93PjMgDojmXXe+Pem6PDjc7y3
 P87HEfg0cJmVCBsBflEkuYtIKIxEKCflkyRiuMnaRnKGM1Kr1qB8ScI4KLybyaC2GtFN
 y4SoeD1WqZyzb0nGtRiKS6rDaSYX3yrmYitr+hFtXeMZ/53/lor7Sc7Os9XMQcJ6Ffko
 vNNee3Kg3qqcTCx3Bmw3ZI/OrCYgca63nbqX7SdLY7LVj6vqWVKyk0nm/8hEuTt5tpY1
 v5YmULa1F9P13pa7gX9UjbFkfK2wIlBcoCvDTy6VFGHH0hh2CJnaxvsY1J409oP+5B3L
 +LGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791335902; x=1791940702; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pZUZVw/r7QKqfHaSqiu3U/sawF5KkSgPe+LInuVqhTs=;
 b=N8kurpoV3j44GHi1PEKwL6wkSGSLK1pDK83fc6vefjfLJAdYerdnU5lZNoYsWEvimW
 EDHSFpjn0aRp8m2UgNAe9bwon5dP3US+hoqs96KgNETvjUOxb328ACS8jiRUF2OLtZL0
 IEnufR08F+g//wNPIC4yNSQYVHVlpie2fM+G8s0rIJhzVM69vmqrpsk5WCt9i/YQpstD
 qEMEdX/c19Nwmqro3UU2r3uOK4hOYxdL7DZJjIyTpxLEdM8XSrspcwFJHCvRpKm0zqFd
 ba+0wyjwbUkNCZGC41MC8BiCtyl0+Y9jXx0VHrLJ7lqeRlQ16EhiLUedgPUOoBOskTG7
 L2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791335902; x=1791940702;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pZUZVw/r7QKqfHaSqiu3U/sawF5KkSgPe+LInuVqhTs=;
 b=UbEz+qLei424ra7UkeMF88L8AVljBfsBtMeTpTqMJKd+TvSK77j7UdgVSi1iMik8nG
 5cv6QH2jSBvpPvSkj1YXjkhokXTrYfmikOKHG1Hnl08XV2nSFJ8yCgaw0ywf0NNnnCdO
 xAfcDiapazp/mfTDVxiP3r03YimdZozfSIRRb6aDs3Em8Rec0zBnP+Lse1mcpCD5/0hY
 V6jHWKaktxFg0bS5X2xW5AgHaggtUpNwI7laZkTG9Clu66AZLIAbp+HRL4h2eTpzSr22
 P73ql2V7GSb2ZM/JffP/3xIpF1StdvFT+Nr90fZjpN1SqfQuq3PYyb5AYbxyKKmW5Ppf
 Ebzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz26njVsAfqE6IeDXVITwzZXCFfP4OWTcheV8Cvmmy5GI17Pgw2nuk3crYc2frdlcvwBsfQt7L0p7s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLQMk/kqrBQf33PtAGr/b+CgzjVIXzfDGngJSqghsyQO5nYqebG
 iICgwurt4BGiyBfM5hKi/lyYE2O6f7C497Kd5zRqvDTVCs4J/lKjZqRicuXHfq2ypBdVtQk50n5
 9gxGSsmt3DmgKCI6J8R7RBGj1iwXUp6o=
X-Gm-Gg: AYBFou2+e8YG59ODTYJOxs5YXuBSCyJtyxJrX77T2p0UQM25AyRnlArLj0lbEeWGG8K
 OX4VVuLLjgpeLLPUwFT9YbQa8LG3K9MWjWr104x25EI+yoDYa5rB2fVsiX4BXTOY9/Ayx1tZi3a
 5n6f2Nns+wvujVDHC+HipfjuYHYuqA8ep/LKL45Hqt2L9OwYYI5lmsqwiIQENHcNKMkjiWb1BjS
 pEuQACjDWlNNJ2Ky9aqpBAiP7vvT+8kDFXEV8lr9nGB+6Sf2eH/754EXdku1S7qJVD1K+GZrqv8
 3TCQAa2a2Ion655OjTrFf7/Th7lwHMmsI/EO6ZLVFpYDs4SLB9cxsCX+kfjqen/UoBk1Iroz/67
 WZG/vcAFX23E9Avt6KmLbGB+dvjZP8VS/JWR0bxm9kylG4uTnNBFuH8LdFrnV1xvLD2X75YOhUm
 tWWYa+IQvq
X-Received: by 2002:a05:690e:4186:b0:677:d35f:c4d1 with SMTP id
 956f58d0204a3-677f3936420mr1935901d50.55.1791335902092; Tue, 06 Oct 2026
 18:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20261006042230.547807-17-yidong.zhang@amd.com>
 <20261006071310.198186-1-0xiviel@gmail.com>
 <8900270a-064a-fc3b-5686-e37ff58c5335@amd.com>
In-Reply-To: <8900270a-064a-fc3b-5686-e37ff58c5335@amd.com>
From: Eva Crystal <0xiviel@gmail.com>
Date: Wed, 7 Oct 2026 14:18:09 +1300
X-Gm-Features: AclHuK8ByFUnVeiePKTeYtrrfEBVhs0HhR6E8dxtr1XBpLY-_TFNVqL2-6knGYo
Message-ID: <CA+pz=kKycVkwNVnQ=+eC3C39TuJ3HeGHiZC-UX1mszV-05rNaQ@mail.gmail.com>
Subject: Re: [PATCH V2 16/20] accel/amdxdna: Finalize runtime PM before
 acquiring dev_lock on removal
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: yidong.zhang@amd.com, quic_jhugo@quicinc.com, 
 karol.wachowski@linux.intel.com, max.zhen@amd.com, ogabbay@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 sonal.santan@amd.com, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=E2=94=94=E2=94=80$ sed -n '/^You are right/,$p'
/home/iviel/xdna-audit/aie4-kmq-v2-reply-16-retraction.md
You are right, and I withdraw the claim.

The step I missed is pci_device_remove(), which calls
pm_runtime_get_sync() at drivers/pci/pci-driver.c:527 before
drv->remove() at :535 and only drops it at :536 once remove returns.
Once that get succeeds, the device is RPM_ACTIVE for all of
amdxdna_remove(), so pm_runtime_forbid() takes the early return in
rpm_resume() at drivers/base/power/runtime.c:820 and never fetches the
->runtime_resume callback at :936 at all. No second dev_lock
acquisition, no deadlock.

The AIE2 deadlock claim is therefore wrong, and the Fixes:
1aa82181a3c2, Cc: stable and split-to-drm-misc-fixes suggestions go
with it. I withdraw the drm_dev_unplug() question too, since nothing
resumes on that path.

I had not reproduced this before sending. Sorry for the noise.

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com
