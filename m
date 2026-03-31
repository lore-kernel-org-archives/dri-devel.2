Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92E81061B2B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 02:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5025010E112;
	Tue, 31 Mar 2026 02:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Y83y0m39";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C3C10E112
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 02:30:43 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2b0c12be0ecso55685ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774924243; cv=none;
 d=google.com; s=arc-20240605;
 b=Y0/J7RGlDbup8DqCsorCatDDS8aWKk34+K6p+Muuhq9e4ZyTOU8/TOEOFKEFdiAdpU
 t+C+7+5//ONy5U97ZwCDw0S0jXnU0x/q6GU9ETuFSYo7eeaWx8KDzL7F8GB17EmfBIJK
 IKBFszUrwy/QJBUGM5DUPV5EblMJGXzrACYsT3+fD8beOyvsZjMauqFT4tEzeamw7qgu
 rYpnz3QQ6Gi24W6VlAuH0uQrGuKPIsPTPppYal/R18MRV7lm6nwtuUAMh5fH5IQJUyK+
 QQigRSjwZcHFHAsVktGR3DlrWw0+pll+0vYlSGaZFbovL3kJ5nYtKEvJ49l77dte5Qp4
 KQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CxEMwE7XhRFVwtUnHZD0iqEi0s+7BCCjt74dKY4n/78=;
 fh=ZJLQcuhgR39Us5cR0Q5ORadUNR0I98arFiZ9f5V5lbs=;
 b=VxFuraQub2U+bzWABRH/NBD2rEzX/clySk3N9nnhjy1L2pe13xBRQu0IQ1S+Wj1fG7
 YsTAwJp6AlUbh6HlNP0rYyUicLsRMwcnO7DXNzjYiJD6hgZCFXN8tFCZ2oO0xXe944G5
 Vv9iGbyvZzUqQkuLN4fjoHMnrBP3R8qI0iwtQlma7JEfeRSTG1QEE+r5K+13yZkJle5w
 VR03qHsYG3qZQRz7aoA22zJRbDs6CeRqSdj8MH6WBuF0XKRt91Pe8/amGUERlj0eeagh
 y6Jw3cvNrFT1Y9eGGiHx+6R4Y5U96XoO/5GWUVbxEqfAvWl7spmZQmWKVCigD2oC1rme
 ZNkQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774924243; x=1775529043;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxEMwE7XhRFVwtUnHZD0iqEi0s+7BCCjt74dKY4n/78=;
 b=Y83y0m39WecmcMutV1iLTG453vV/TjK6odmBXso89nxOm4Z3VlPsBN4KJnLhIiPRLP
 v2gEWHrNtNfxZrLsGUsu6peqiN422x//BxZ2PBpWyPF/wC/t22mFz8gNcvV6GvEO5Ty3
 Tgs+Zg+ZSAFOJIf5Zwa5drmSbxR+RfxU1X8CLQtNuKS7GERO8hKTuqXC9m2C8cs/lIj8
 sPwRrKMn1sGjPlZ5osJ4t7rFGroChEZeXSiXrypwLfHbDWKspNlIi1o7DBVOP2ZArbtN
 8kViy940JpdIV1fzynEz3rwcW0iZyrpC5tb+Sc+uo/SlqH4kcSaaEZJg5lJyXZwfrjCr
 41wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774924243; x=1775529043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CxEMwE7XhRFVwtUnHZD0iqEi0s+7BCCjt74dKY4n/78=;
 b=XCWEVF75GJGOPT+l4c58EsUoAKRCBTp5FwBFkwCiv89pvaYL8u1fJX+N9krSCruNt1
 V90Dohgpd21kZUj7WwzNWsed2Ha0n//6N3pgLfHnqJd4OicSA6htgTp9JKFOxSntWgyu
 WAGIWPLnFvzvBnel7htvgxDv5ZUCkDjuLweBhwx0Ys056haYxYqzYh/WMI1zx8XEqTm9
 1eBOT099olXRFAP9Grb5/cUXs8xc9UY8ADUchbPnNKt21CHyW24dael/AQp0V7YkFjRM
 Je3fchkpMghaAwbVKWu1BUhcMCyJ6fdBH7ROMxxQkrS65mhueLivmzOBPVOpqWQ1ZZMl
 r/Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfG4+ZKlAmxh03mnW+vfE8QqXc9ttNkFL5og+1evx2uT2mj6qvIKz8v6dwwOrVmY0SrANDizRwMr4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAHyHlOJ3nnBRLAZxkGJye26o8OgY6KP0jFLRzsLTyRs9ZXYNo
 ILMGQVJc5e2CoEfrvln694uT6jz9VMGQZ/evzOfIBtHWdxxWO06z+dU5N6GkgAWB1LDeRZ6ca0T
 UcxkzwPVLFkU8Fk/Ngnkzr6lB1tsgwmWPl0TRu5NW
X-Gm-Gg: ATEYQzzeTKNNRbd7bE7oBvUNyahpWdtPyaV7Yfmys5Yt1vys7MtP7EIHVvnIlbpOk4u
 qZEVAYwZofPaoca2ZLT0AIaLewWAf7SgQdQ4MVznZdSkqEVD8U0zKCMp/+rg5BrhYffjO46ZwXb
 WmIp6DDWbSdJ8irURCWj9bh4y39UfHw38+Brz0TT2E28LhBZHN9VkXqR8BlBRj03tOrkI/Kaiti
 CMVo8gTLx2nNWJ3tO7spw/Fdd4H7EADRgoxcXvq5uqULM5lSjyb3saywrx3CUzJ/+aAvrTDCyhf
 0xfisgts8ThU9LMqLy4=
X-Received: by 2002:a17:903:4b04:b0:2a8:ffed:4663 with SMTP id
 d9443c01a7336-2b25f7e1e32mr2002305ad.12.1774924242081; Mon, 30 Mar 2026
 19:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260324163159.2425461-1-lizhi.hou@amd.com>
 <1e573513-b281-4ae3-9140-7a87ee9dab08@amd.com>
 <45bc86ee-cc0f-2b99-f876-9e8861be365e@amd.com>
In-Reply-To: <45bc86ee-cc0f-2b99-f876-9e8861be365e@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Mar 2026 19:30:30 -0700
X-Gm-Features: AQROBzDU0-cKOCBMRHhVZ8CqXZdjaby5Txt2fmg0-hRqPl67nKIIzlqK3g0pp3Q
Message-ID: <CAP-5=fWFnuZt5CvF--qLfsp6eKkCSUHttCVzp_pzEqT57ZupDw@mail.gmail.com>
Subject: Re: [PATCH V1] accel/amdxdna: Add per-process BO memory usage query
 support
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, 
 dri-devel@lists.freedesktop.org, maciej.falkowski@linux.intel.com, 
 Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org, sonal.santan@amd.com
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

On Wed, Mar 25, 2026 at 11:47=E2=80=AFAM Lizhi Hou <lizhi.hou@amd.com> wrot=
e:
>
> Applied to drm-misc-next.
>
> On 3/24/26 10:01, Mario Limonciello wrote:
> >
> >
> > On 3/24/26 11:31, Lizhi Hou wrote:
> >> From: Max Zhen <max.zhen@amd.com>
> >>
> >> Add support for querying per-process buffer object (BO) memory
> >> usage through the amdxdna GET_ARRAY UAPI.
> >>
> >> Introduce a new query type, DRM_AMDXDNA_BO_USAGE, along with
> >> struct amdxdna_drm_bo_usage to report BO memory usage statistics,
> >> including heap, total, and internal usage.
> >>
> >> Track BO memory usage on a per-client basis by maintaining counters
> >> in GEM open/close and heap allocation/free paths. This ensures the
> >> reported statistics reflect the current memory footprint of each
> >> process.
> >>
> >> Wire the new query into the GET_ARRAY implementation to expose
> >> the usage information to userspace.
> >>
> >> Signed-off-by: Max Zhen <max.zhen@amd.com>
> >> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> >> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > I'm assuming you also have userspace side ready for this too right?
> > If you have a link handy can you please include it when committing.

Sorry for a naive question, would support in procfs be possible?
There's support in perf for displaying DRM usage stat data from there
[1], for example:
```
$ perf list drm-

List of pre-defined events (to be used in -e or -M):


drm:
 drm-active-stolen-system0
      [Total memory active in one or more engines. Unit: drm_i915]
 drm-active-system0
      [Total memory active in one or more engines. Unit: drm_i915]
 drm-engine-capacity-video
      [Engine capacity. Unit: drm_i915]
 drm-engine-copy
      [Utilization in ns. Unit: drm_i915]
 drm-engine-render
      [Utilization in ns. Unit: drm_i915]
 drm-engine-video
      [Utilization in ns. Unit: drm_i915]
 drm-engine-video-enhance
      [Utilization in ns. Unit: drm_i915]
 drm-purgeable-stolen-system0
      [Size of resident and purgeable memory buffers. Unit: drm_i915]
 drm-purgeable-system0
      [Size of resident and purgeable memory buffers. Unit: drm_i915]
 drm-resident-stolen-system0
      [Size of resident memory buffers. Unit: drm_i915]
 drm-resident-system0
      [Size of resident memory buffers. Unit: drm_i915]
 drm-shared-stolen-system0
      [Size of shared memory buffers. Unit: drm_i915]
 drm-shared-system0
      [Size of shared memory buffers. Unit: drm_i915]
 drm-total-stolen-system0
      [Size of shared and private memory. Unit: drm_i915]
 drm-total-system0
      [Size of shared and private memory. Unit: drm_i915]


$ perf stat -e drm-engine-render -a sleep 1

Performance counter stats for 'system wide':

  557,542,732,344 ns   drm-engine-render

      1.001575975 seconds time elapsed
```

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20250403202439.57791-1-irogers@google.com/
