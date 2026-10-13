Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A263ACC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFF610F5AF;
	Tue, 13 Oct 2026 07:53:29 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B39010E719
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:04:26 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7f48c750afcso1933790a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 22:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791867865; x=1792472665; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gTdVETudrkO9g7BtMaM+WFIY64QBuvndlnKmd0+mElY=;
 b=K3cihy28Xr8rTeRHhYYY5FNP7giIk0P7rmABizFxwGI4yzb9+jfuDOfAtcC9/QyM1k
 JpeRGuh2KKdY6i0zBA70Szk8CCkpioB56ukds37vmPua5OGVJnwVOA41O/F70j9fFVuk
 7d1pbhBqh4DJOWAKCyTS51Dy/OjoHBlJ6X/n5ARC4I17fN4tzbvrguPykIMy8hnNo9+f
 rlbiQSb1unCWB4t4ljOWDZEqN5qb3cHtt+59JZ/LOHSkSHWbDCUVIoZnS23AUxG03qL9
 rgvfDowzT0kKFb2OBtnDBIm/fHlFwUu+Qlpq5ciu3SRFSrZCn5HssdIZ+x+BKZhko7li
 fdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791867865; x=1792472665;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gTdVETudrkO9g7BtMaM+WFIY64QBuvndlnKmd0+mElY=;
 b=XwbGFtHrVZPqqAPAiWqOFVP/lUx3LltT3foxQYx2Ma8s5PxE+C32MnFuor8A2kKTMu
 NRr9g+QEyR5VSVfCZncIczgdPGtG2TnzLNHYLz5RBdKcg760Wx90vgNichAgnVClYkkk
 O3dv6DwRW5GVfktbPwyA7RdHH4/amIU+tXxGWSGMaC5Ll7BstgIa6AJZZpb2rtHTHrY6
 V+7ORpQyKDopK/vIJLcqgwHQrGoDqgXGUPRjLFHCF/Jz9mF95LmSabX6fSC9U7zCI0WZ
 r6D30eCDU4PieIBRq3JadftOZosBg7mKj+lFv3/ALaDrvybFjW2PRTlLbPXbBm3tvwm9
 om3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuyVHEAFdCeNz4jXrMnYw+Fb8n1FH8rDfG2DSRyhr0MPIBnBFqvpFPv+BHom1cl/Pvwk7rLmf1tYA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKssli1JsLWhwb/CgfFxckZCw6yIIbQC7cLd/JlC5x+a0FPeWpT
 9QJ1bc1sM45rBTaQD6QtzMBCSZCB24K18XskW/3EnRdIpjcKJs1iNzeH
X-Gm-Gg: AYBFou05be95JNmRg6F6ulwacLHXWz0fOcuBK7KOU9o1yozh4cOg4G4PNFzOcERgC0N
 hdYNEYdiAQLpNXr/OYEjUcAw3i9ZKVyS2BbE2NtbYrVLFkF3tOpnnKNPJ5tt+OVTZioIPga5dgD
 rYePwWPz/6406/8APoRlPFRnMjhANH8aUTlpPY2IcTcupyPzpMJDl4RkRHajWdYhdSAJXJj/Z5h
 QqEv35RvIMxni2wpy1bWQCMNp2R5F7iY+YfHuAw2HpD70oOQ0fcE+gvM/Raoyx4GO/bzBtNDeQv
 QcoI9XkQo22Dh+OsfnKDxGCAKhxMIyXZJUHP+fWbf3qbGwPYdEkNN9fjd/oqmMNdPQtqbQ4UyV9
 kefjW4oJZ7dDKyoRTwKhuoR7j/PwDsLIMEsB8eDqcjwtjmhMYSqmdc78wqYIUlynX+KwSJRxgek
 NAXYLYWC0VG2t+YomVG0Jw0AxLSaAv9MyiwTgob5o5UkXPE4fGKck7tgBbH2WSdGW0mCm+4duxS
 ebu5/4pQBFBRQ==
X-Received: by 2002:a05:6808:2215:b0:4ec:4c7e:37b5 with SMTP id
 5614622812f47-50c541775a7mr10580195b6e.29.1791867865451; 
 Mon, 12 Oct 2026 22:04:25 -0700 (PDT)
Received: from gmail.com ([108.243.219.47]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c167544b5sm13557623b6e.3.2026.10.12.22.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:04:23 -0700 (PDT)
Date: Tue, 13 Oct 2026 00:04:22 -0500
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/4] drm/panel: newvision-nv3051d: Use
 mipi_dsi_*_multi(); fix minor bugs
Message-ID: <as24ZjtrzICOkcj3@gmail.com>
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
 <20261012-mipi-multi-series-v1-4-6a29add1ec92@gmail.com>
 <sashiko-outbox-168984@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-168984@kernel.org>
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

On Tue, Oct 13, 2026 at 04:43:35AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does panel_nv3051d_init_sequence() mask initialization failures?

This is pre-existing: panel_nv3051d_init_sequence() returned 0
unconditionally before this patch as well, and the cover letter calls
it out.

My plan is to send the fix, returning dsi_ctx.accum_err, as a separate
patch once this series has been reviewed.

If you would rather have it in this series, I can include it in v2.

Sashiko AI review: https://sashiko.dev/#/patchset/20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com?part=4

-- 
Thanks,
Akash
