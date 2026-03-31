Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC5A10F92E0
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EB910E1BD;
	Tue, 31 Mar 2026 16:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pheKGjDl";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C3810E1BD
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:19:15 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2b0b260d309so87865ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 09:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774973955; cv=none;
 d=google.com; s=arc-20240605;
 b=MtzAv1dKKHlziM1R/IkNw1F/OdQeUefbsn33BTSCb2Li9C2zCbYKqrzw0fXHNCs/9V
 o1hBEQ7+ScKGDxaxPmGoZIGALO0mdArZpS4MBU64hKwwYIDfGQWyS/QAx626c5vwgE8P
 UCq/JOUSDiGIx7d7JcvSIdzYP2XYT/wxKWImndfzIMiGTvZWRwfzIQnRTnOrFfbBy0Bg
 3T592a+Gnu1BFTnKnYWt7wpmacO8brW1VCUeyQuRuyi0+EQgMUr/7ilnPcuAaSB3N3TX
 RylMzqfEVlyPSVzTq+ednhyx5GlkW1VqU8yjOc8/4c0A9iZGtdP9EBTTPY6syXgqxBmf
 VGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Yz4zTzdGz0GMI/kyoFKj7Dyj2wzkwVO8lfeZp7FBsRQ=;
 fh=6F9dBllsekWQ4z3iFSW3qcT9myMFIdRf2yHT0F5dV9s=;
 b=Pb7Y6GmOWMyh++QDaRAKVv9obnt1so8magza3lMK+Rp0SovnBBtmc6z6GVmErjxAKo
 RMD3R+ZKhVXh9ysC2pvKujF42MJO4nRa6gX3zWqIbOxDmwflGCA1ZRViOn5tMmvuW7MN
 dsa8OxQ9Zs0MDdEWSRESs834G1ZzMGk5RUnNv7E+a2yfJbN80A+wtZP95YezVsXIY4St
 s/9DC811FkagAIKQEim+SYf167AZ0P2W+FwhOQQPCsEN4FL8DbujtD9T2GDCX6wVH99B
 ez02lAR1wa4e8Ul+h1M9hJZNOaLZRwG3r3wD6K+F5FHJ5bq0qPmSpl9uIFGk+pQag2e8
 q0EA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774973955; x=1775578755;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yz4zTzdGz0GMI/kyoFKj7Dyj2wzkwVO8lfeZp7FBsRQ=;
 b=pheKGjDl0I4SThnDLD0r34zRNQ6qNQYdsZmYlznSaUiJycjK0BgNuYWjOE0hz+eWah
 bUvUGVAf6HwDa7P4MmGiyP42bbijS5+qYr5d9jBlyajvymIiewL36o/fhloe5C3OBijY
 fSWRn/WvVPekE4wstE9DS6I7aWwtjOdp6yNIjn/QcWCEa6EAkIw7+OtAFkG6NVQkEdk0
 O+BkYrl6xFTkOckPVhKNmuSOkXQfDANW63HiOtqyGv2nQBlFPf1A3Moq/lfpAbYwzrA3
 wjV4TNX+d2gY0BlXERUBB4yM7eUKWmDyz/x9oeOjOuWIKUN/47zyOQe1k1s6JIG9wjr5
 Ib+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774973955; x=1775578755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yz4zTzdGz0GMI/kyoFKj7Dyj2wzkwVO8lfeZp7FBsRQ=;
 b=DxneyOljHVLA9YxXalmu4FNojh//wI5L9l3X5NDgQ6x9TTEqTLUeZNCIn+eU+1VFwb
 j7RZSDpDET/46esyHpqJnHQBBHXaRiPzOT6g3An6iJ40A9/Sz1z7xKz01YAS1k7+/qwW
 q0WFmD4NiaOy/eE5IKIky/TThz66qJ3KnL1EjlfjmcOVFXl3exzedM+sAqKuFrqNmBnZ
 TJ5nIoHaikWONBvz7+rZhM0iqgwGwm3h5/egKAnNM959R8uvGjgiL8N9TadtdheK/pJF
 3jn4MXn61p5xXxhZ1ZFubh6oVBxEYnkpZb/KJhta+RWGNzGqbycukeBeosTJbEnovdiz
 vNfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSZOEwH8yGeWRlR8jMOaHNd6cU8pW3WF63mz3EOO+WJjtyOM3PGol26WCXOCyZ7b4X2UsPAMhj9oM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJDR062uLLqq/h/Ap+oqU4NnbS2DqahmXRpfEvXCrHUwE2ZKWT
 ClKya0IXVP7niD1hEIT0qn4davwu3qyYnr8TN30tqoLgU2zca8YDKRE3pxCJQWOqPv1f2QNT6za
 kXRpMXRVUpF1UV58XZlv0IB//ZrkPVsW7WcvmcyWD
X-Gm-Gg: ATEYQzz19M77fzbI/ziKPMcmMYpMWMeMTE6KPtrN4ln8/Ofvfclp1gVLf7lFq+2MizY
 TLkTMaUV8tLg+si8Z2oNOUDBCmWHeQvSxaUsx30i0JZOYqWX3VVSEyQQ4gLqnst6/iawAilrqh1
 SxMAtwYrNSwA12EZRMGOOCrWDNfhSHI6eqPLcM09ZkNGmXzfBwHCE1qKhJahcyk9leWzq3Mb1PI
 +N3cX8ZlvOgulW0D3jj0/W6N7S06+2KJhspq+oMQoURVUpPoqbSZXf7cmDst/5UiEf37GUKygEU
 D1XDs3Xuyu6bG24yse8jZEKpnxG3ZlIsrEdPu9leOXFlRQ1K
X-Received: by 2002:a17:902:e787:b0:2b0:5193:1212 with SMTP id
 d9443c01a7336-2b268d7c5ebmr272165ad.4.1774973954057; Tue, 31 Mar 2026
 09:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260324163159.2425461-1-lizhi.hou@amd.com>
 <1e573513-b281-4ae3-9140-7a87ee9dab08@amd.com>
 <45bc86ee-cc0f-2b99-f876-9e8861be365e@amd.com>
 <CAP-5=fWFnuZt5CvF--qLfsp6eKkCSUHttCVzp_pzEqT57ZupDw@mail.gmail.com>
 <d677429c-9ed0-5c05-02c3-05a375e46c38@amd.com>
In-Reply-To: <d677429c-9ed0-5c05-02c3-05a375e46c38@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 09:19:02 -0700
X-Gm-Features: AQROBzD1l9mHSjgp_pJ6JSMwOVl0FVsGNew6txGydhpIvX85jhJmSYlk9z0W5rk
Message-ID: <CAP-5=fVv5fSffotLijgdGX_UxFJy8wV0mEGed3_f4VbmCtPcSg@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 8:53=E2=80=AFAM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
>
> On 3/30/26 19:30, Ian Rogers wrote:
> > On Wed, Mar 25, 2026 at 11:47=E2=80=AFAM Lizhi Hou <lizhi.hou@amd.com> =
wrote:
> >> Applied to drm-misc-next.
> >>
> >> On 3/24/26 10:01, Mario Limonciello wrote:
> >>>
> >>> On 3/24/26 11:31, Lizhi Hou wrote:
> >>>> From: Max Zhen <max.zhen@amd.com>
> >>>>
> >>>> Add support for querying per-process buffer object (BO) memory
> >>>> usage through the amdxdna GET_ARRAY UAPI.
> >>>>
> >>>> Introduce a new query type, DRM_AMDXDNA_BO_USAGE, along with
> >>>> struct amdxdna_drm_bo_usage to report BO memory usage statistics,
> >>>> including heap, total, and internal usage.
> >>>>
> >>>> Track BO memory usage on a per-client basis by maintaining counters
> >>>> in GEM open/close and heap allocation/free paths. This ensures the
> >>>> reported statistics reflect the current memory footprint of each
> >>>> process.
> >>>>
> >>>> Wire the new query into the GET_ARRAY implementation to expose
> >>>> the usage information to userspace.
> >>>>
> >>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
> >>>> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> >>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> >>> I'm assuming you also have userspace side ready for this too right?
> >>> If you have a link handy can you please include it when committing.
> > Sorry for a naive question, would support in procfs be possible?
>
> Do you mean fdinfo? And yes, the fdinfo is in our upstream stack. I will
> post the patch later.

That's great! I did mean fdinfo. I'd be interested to see the patch,
and possibly the strings matched in perf need updating:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/drm_pmu.c?h=3Dperf-tools-next#n183

Thanks,
Ian

> Lizhi
>
> > There's support in perf for displaying DRM usage stat data from there
> > [1], for example:
> > ```
> > $ perf list drm-
> >
> > List of pre-defined events (to be used in -e or -M):
> >
> >
> > drm:
> >   drm-active-stolen-system0
> >        [Total memory active in one or more engines. Unit: drm_i915]
> >   drm-active-system0
> >        [Total memory active in one or more engines. Unit: drm_i915]
> >   drm-engine-capacity-video
> >        [Engine capacity. Unit: drm_i915]
> >   drm-engine-copy
> >        [Utilization in ns. Unit: drm_i915]
> >   drm-engine-render
> >        [Utilization in ns. Unit: drm_i915]
> >   drm-engine-video
> >        [Utilization in ns. Unit: drm_i915]
> >   drm-engine-video-enhance
> >        [Utilization in ns. Unit: drm_i915]
> >   drm-purgeable-stolen-system0
> >        [Size of resident and purgeable memory buffers. Unit: drm_i915]
> >   drm-purgeable-system0
> >        [Size of resident and purgeable memory buffers. Unit: drm_i915]
> >   drm-resident-stolen-system0
> >        [Size of resident memory buffers. Unit: drm_i915]
> >   drm-resident-system0
> >        [Size of resident memory buffers. Unit: drm_i915]
> >   drm-shared-stolen-system0
> >        [Size of shared memory buffers. Unit: drm_i915]
> >   drm-shared-system0
> >        [Size of shared memory buffers. Unit: drm_i915]
> >   drm-total-stolen-system0
> >        [Size of shared and private memory. Unit: drm_i915]
> >   drm-total-system0
> >        [Size of shared and private memory. Unit: drm_i915]
> >
> >
> > $ perf stat -e drm-engine-render -a sleep 1
> >
> > Performance counter stats for 'system wide':
> >
> >    557,542,732,344 ns   drm-engine-render
> >
> >        1.001575975 seconds time elapsed
> > ```
> >
> > Thanks,
> > Ian
> >
> > [1] https://lore.kernel.org/lkml/20250403202439.57791-1-irogers@google.=
com/
