Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4181BCD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5143210F8D6;
	Fri, 29 May 2026 05:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xzh9RjA2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E11310F8D6;
 Fri, 29 May 2026 05:42:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6B784424D;
 Fri, 29 May 2026 05:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA9C1F00893;
 Fri, 29 May 2026 05:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780033327;
 bh=QGwvFXx+5cG1GHQMmRBQExTGLL2RZ/Uhtgw3IV9hTM8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Xzh9RjA22Qoa5xv4MQo/QIkKAVuneF/MVrWo7rqI8q5Qz8+Y6xg4tWQAkjPe/bc+Z
 y5ppN7sCtoITnhqvm4n9+WFjySIjKWsO3V0k1XpZvfDZU4uoOjgecGhhWWjbA9iRo6
 eO/GNw5yWhzuhQLpeIcenDRBnf5W6fzGXe1sQUX+20CpQlFlO1hP/IdmVw4Zz4rCZa
 eGENxn1t0LxwBFtTxYf4DZpzQdxnP1D5FNSSGG4YlOe1Rpw83aQpHoGjFdCKhYpF/X
 3+EBQLw5TuvI3uAmuOaymlHidRXrDoaSx9HTgSrWoZtO0iBifxOFYN9h/Xe8VCdvjT
 WI4euBHEbDBCw==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
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
Date: Fri, 29 May 2026 07:41:39 +0200
Message-ID: <20260529054139.120182-1-ojeda@kernel.org>
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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

On Thu, 28 May 2026 21:42:09 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.11 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 30 May 2026 19:45:49 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

For arm64 and arm, I am seeing:

    drivers/gpu/drm/msm/msm_gem_shrinker.c:105:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
      105 | purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
          |                                                          ^
    drivers/gpu/drm/msm/msm_gem_shrinker.c:117:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
      117 | evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
          |

This looks like it was fixed for mainline:

  53676e4d44d6 ("drm/msm: Restore second parameter name in purge() and evict()")

and was queued for stable but maybe not picked yet.

Cc: Daniel J Blueman <daniel@quora.org>

Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org

Cc: Nathan Chancellor <nathan@kernel.org>

Thanks!

Cheers,
Miguel
