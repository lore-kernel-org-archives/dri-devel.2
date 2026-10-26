Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80599606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=sBzeQInx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E985610F1B1;
	Mon, 26 Oct 2026 23:05:10 +0000 (UTC)
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DA010F1B1;
 Mon, 26 Oct 2026 23:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4jD8NJ6J04z1XM30g;
 Mon, 26 Oct 2026 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1793055900; x=1795647901; bh=mS8o8LE6/P7UzDYNIS5DVu7f
 5ackztetuCI0LIcPVJM=; b=sBzeQInx8PZvDhu8NsER0CYGZkvuTLRrEXHT42BJ
 gZKm3LtXPTIggtiAJNalbsFDFo6KZL/dPcbgIJq3GVmHdEbqo7ijsF18hD0rSOkI
 b95crvdw54jp10BaWbu3fBaL7kQTkI2JVMKjlcR0G3sWNCLpnorx3HT/SP/DLdYV
 OzXcIR5VKo1wArVaPrG6Xhtcj6b631mFSvUwuFyHcI4fooFEROYx+wjg75F1X/1W
 9OSR6TQekBiHMhZ1dGMW+XmTQx+4yHOHckLgqU1ZrriHwiY8eWWbgfTFZzUG1HPm
 JFJVrOEzXffSthzNqkpNYcJFgCDF85jgtGAcOaRUt+4McQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tWaatCI9yzHm; Mon, 26 Oct 2026 23:05:00 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:d824:fc54:e646:594c] (unknown
 [104.135.182.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jD8NB36pLz1XM4Tl;
 Mon, 26 Oct 2026 23:04:58 +0000 (UTC)
Message-ID: <78ae70dc-bbfc-462f-9c79-632b97543f7a@acm.org>
Date: Mon, 26 Oct 2026 16:04:57 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/gem: Add some cleanup.h
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261026213701.22126-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261026213701.22126-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 2:37 PM, Rob Clark wrote:
>   drivers/gpu/drm/msm/msm_drv.c        | 38 ++++++++------------------
>   drivers/gpu/drm/msm/msm_gem.c        | 41 +++++++---------------------
>   drivers/gpu/drm/msm/msm_gem.h        |  3 ++
>   drivers/gpu/drm/msm/msm_gem_submit.c |  6 ++--
>   drivers/gpu/drm/msm/msm_gpu.c        |  3 +-
>   5 files changed, 29 insertions(+), 62 deletions(-)

Please consider adding the following to drivers/gpu/drm/msm/Makefile:

CONTEXT_ANALYSIS_msm.o := y

Thanks,

Bart.
