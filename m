Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4BAE9DE64
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6AB10E761;
	Thu,  9 Apr 2026 08:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FAMP4WVG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467C210E75B;
 Thu,  9 Apr 2026 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775722181; x=1807258181;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=vKvbBqDP87heWpNDUVKUHVquqx+uF6Oad/eR8x+MU8A=;
 b=FAMP4WVG0x7onnSqtncCFxKWhZ3ZnKmRNEaZp/JjcMecBI/3JKRRrITu
 nd5tWIJi3AON5dau6jH9tbNewu2gFYcEhxi/Mt2+U0CfDfzN1udEZDYHC
 sjle4r6+T+scLxBSKAbOODETkNaWEFXgA1pQI9zGmD9wsWVa99FSkdw7H
 p/vveUalfMQEgsqAiPqYrlGNNsrGm89do1v4ciQ3dq0Lf4G0Jb0/BcDn1
 N1kONzkVbYsk+BeNv0nD73FHdr/Xj3VxNTTSdVSG9PEKvVUzHY0mkGixh
 cy2t1y3N+MkX8xGYBwLWpU7cOSG5vatYNXE8RQCt8gZotZf1lqDA3lNHR g==;
X-CSE-ConnectionGUID: wq507l3wRRqEoczib9x62Q==
X-CSE-MsgGUID: nxNHlnAURPywEVrtSW5HKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75892763"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="75892763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 01:09:41 -0700
X-CSE-ConnectionGUID: ya6VTcyxSxanFbg1YWpwSw==
X-CSE-MsgGUID: gciFVPZsRxSnOokFCTCKUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="259148489"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.62])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 01:09:38 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Simona
 Vetter <simona.vetter@ffwll.ch>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Jouni =?utf-8?Q?H=C3=B6gander?=
 <jouni.hogander@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 1/6] dma-buf: Remove old lies about
 dma_fence_wait_any_timeout() not accepting some fences
In-Reply-To: <20260408233458.22666-2-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
 <20260408233458.22666-2-ville.syrjala@linux.intel.com>
Date: Thu, 09 Apr 2026 11:09:34 +0300
Message-ID: <8963fcfe824675600e932dd9020d114b190d793b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Thu, 09 Apr 2026, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> commit 796422f227ee ("dma-fence: Allow wait_any_timeout for all
> fences") made dma_fence_wait_any_timeout() accept any fence, even
> one with a custom .wait() implementation. Update the docs to match.
>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Jouni H=C3=B6gander <jouni.hogander@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/dma-buf/dma-fence.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1826ba73094c..2c623c0221e2 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -884,9 +884,8 @@ dma_fence_test_signaled_any(struct dma_fence **fences=
, uint32_t count,
>   * @idx: used to store the first signaled fence index, meaningful only on
>   *	positive return
>   *
> - * Returns -EINVAL on custom fence wait implementation, -ERESTARTSYS if
> - * interrupted, 0 if the wait timed out, or the remaining timeout in jif=
fies
> - * on success.
> + * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out,
> + * or the remaining timeout in jiffies on success.
>   *
>   * Synchronous waits for the first fence in the array to be signaled. The
>   * caller needs to hold a reference to all fences in the array, otherwis=
e a

--=20
Jani Nikula, Intel
