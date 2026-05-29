Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51C0CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 19:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B6510E394;
	Fri, 29 May 2026 19:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M0WjBapV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E4310E394;
 Fri, 29 May 2026 19:17:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6CB740102;
 Fri, 29 May 2026 19:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F841F00893;
 Fri, 29 May 2026 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780082221;
 bh=0C1XFindTmOCxaEJeiFnyQB6IclnU6NNAqwkt/R8GoA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M0WjBapVLvZAl1XFj6DW2FWhuqS79Nc48C4O9hQsIdJ/stWWJniB5vmZqwZ2F+14Y
 /n17HiZ2Vc2gCM4MVEnruRGqCAi53wEyysP5cPEerB+2Okgf9O+jREcBrPVUjAAxri
 zEfDIy3UvBe9jYcJg/8eBuMiAYt7ECPjmX735TDvgt3yoJGxjeCva9pZtCLWmNUA95
 qHCswE72SdmS3t3y9VEpDR2UY1evTSt48ei8gPLk7JkSCbQpwdece+HKZLTh3rUAvb
 y5NUWzRDhUd+U5AqeK5tyljAUh0EVhiXfRRpIyBNQ0Kuyhs/L8fIdCyNyDm3qNarnW
 0Pc0GPqE+MDhA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>, achill@achill.org,
 akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org,
 f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com,
 linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org,
 patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
 shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
 sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org,
 Miguel Ojeda <ojeda@kernel.org>, Daniel J Blueman <daniel@quora.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
Date: Fri, 29 May 2026 15:16:55 -0400
Message-ID: <20260529185046.rc-reply-001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529054139.120182-1-ojeda@kernel.org>
References: <20260528194646.819809818@linuxfoundation.org>
 <20260529054139.120182-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, May 29, 2026 at 07:41:39AM +0200, Miguel Ojeda wrote:
> For arm64 and arm, I am seeing:
>
>     drivers/gpu/drm/msm/msm_gem_shrinker.c:105:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
>       105 | purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)

Thanks Miguel!

> This looks like it was fixed for mainline:
>
>   53676e4d44d6 ("drm/msm: Restore second parameter name in purge() and evict()")
>
> and was queued for stable but maybe not picked yet.

Right. Rather than dropping the deadlock fix, I'm queuing the upstream
follow-up 53676e4d44d6 ("drm/msm: Restore second parameter name in purge() and
evict()" for both 7.0 and 6.18.

--
Thanks,
Sasha
