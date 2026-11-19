Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14771606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fromdisposition.org header.i=@fromdisposition.org header.a=rsa-sha256 header.s=mail header.b=oKvRxX2e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60EE10FCEA;
	Thu, 19 Nov 2026 07:48:55 +0000 (UTC)
X-Greylist: delayed 399 seconds by postgrey-1.36 at gabe;
 Thu, 19 Nov 2026 06:26:51 UTC
Received: from 4do.net (4do.net [51.68.154.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8DE10EB84;
 Thu, 19 Nov 2026 06:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fromdisposition.org;
 s=mail; t=1795069209;
 bh=vJhhUK2qeCwHwcuSsVyrimotDOPw1sQMAeLglbbQQzg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oKvRxX2eo4Zr/C6fyFqHG8jmF5ric74WFGJ7zMaA/uceIZ5wPFrHp1LKlAdiHozTy
 Iph9SLiNwgTWmYssfOgs+d6/DMsiFzCm+ZUySYGqMZ6OjMAue3eMeNtOYAnTO3iaSq
 EgNj2l7BJvFuV+mDV7eMh6Pw5WI3X9IMlDpZJts4KCFKKLvxh4sMkm+Hi8Sqh1HGzx
 7hPxAOgegh1AKMet+fgKkHNNduQyl9adtlRWeCtKh7q/EgKRoUxSmlReY+4HnMs1KP
 e6CTkrLJFPI6zlUH2/U35S/7wcmx/29o64HMJjQ1vEe1CO4gZ7NucgzIO8a22jajIQ
 hkM9/rralkbFQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Nov 2026 06:20:09 +0000
From: Demeter Barna <me@fromdisposition.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFT 7/8] drm/msm/a6xx: Add IFPC tables for Adreno 650
 family
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-7-6992841a9a32@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-7-6992841a9a32@oss.qualcomm.com>
Message-ID: <bf7ecfd7ca2da3ba64c0222c52f750a9@fromdisposition.org>
X-Sender: me@fromdisposition.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-30 10:04, Konrad Dybcio wrote:
> Fill out the register tables to enable IFPC on these SKUs.

Hi Konrad,

Tested on an A660 (SM8350): the ifpc counter goes up and there are no
GMU errors. With the GPU held at 900 MHz under a light 60 fps load, the
device draws about 0.3 W less on battery than with IFPC blocked.

Tested-by: Demeter Barna <me@fromdisposition.org> # A660 (SM8350)
