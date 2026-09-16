Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2C4C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 05:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98CB10E036;
	Wed, 16 Sep 2026 05:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="mpz2+FK9";
	dkim-atps=neutral
Received: from smtpout8.mo536.mail-out.ovh.net
 (smtpout8.mo536.mail-out.ovh.net [51.210.91.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB20910E036
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:32:01 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hl6vf6qtYz89Dq;
 Wed, 16 Sep 2026 05:31:58 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <arunpravin.paneerselvam@amd.com>; Wed, 16 Sep 2026 05:31:58 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.187])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hl6vf5vx4z46ZB; Wed, 16 Sep 2026 05:31:58 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.5])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 8639A9A1C21;
 Wed, 16 Sep 2026 05:31:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0051070beb6-b773-446b-8d4f-44f46e538ee6,
 69B76013C106EEA375DAA2C64D98DF65BC6C8E4B) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <06ba629c-192e-4a65-a48f-0f61b7037c7b@pixelcluster.dev>
Date: Wed, 16 Sep 2026 07:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 christian.koenig@amd.com, ray.huang@amd.com,
 arunpravin.paneerselvam@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260915154804.605772-1-christian.koenig@amd.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <20260915154804.605772-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 3012345201672020284
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFRfwPuXz5e3IWqGYPDEKHZ3x/M2YZGSZ8E32VVcwMb1j3KKBl2m+tUHN2rZrm0fucxlaeylCZLlLoFNNxPvCVmDDGLqP/abZiAUzT6vOW7ZsA4E2YR8C7feuD4+EjwKWiCxuDBaUzUlgnZ7UW3A/bcBcHOu0KMTTRVRDhp/QqaXvZednGeQ973KFdCRKyqcvISUYeoqzBlNgLYv+/OYTATaSOA7mtAneBn9N3cQTzmKSzF81pAvYcIG3meuA6y2M4j6cw4s0QTyDjoYkyPSfLhZkt5Xc3SonFVlrjooVE5qQy8nOrldhuZ700d3btYSV+SMyKdXXmbTBj0RdYhCLkcT8iQCRGcNFiimQc1yvyb+gUsSc96f9rd0DMZJPlvWEV/kakVVw1PTCovHZRrLWtlaPkWSTteM1SGd7mQLQkrjJfa84thnAqDp7BAfUMKANCwPoL7LMhniZg2uaOw5uY8uje4fu+rs3stns+CsGYC4bCD1MXLPLQfuVm5Hk3iPuS2uMQBTFwAqkNq0CYOEv9aJ2edVUkxO6DbMQSpFsM1dM72Ipr3W/F+Vn6xy1MwQX4GUUT2+z+j83qrlFSuDpd+JbWSx9hKXVIp9i/MUg5+vXozSPKFkzCQhwlo89RpPjgtZ/jiIHksDeLI/Pj9Q2HBaAX7NpydA4elDca8WlsjqA
DKIM-Signature: a=rsa-sha256; bh=ioPl4fvpUxZb/jtEXguIL+7E9wHogFQsb1NAV9MRKf8=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1789536719; v=1;
 b=mpz2+FK9rbNsHe2aDHrnKz+gAmGH6p+Ap+EWyc6Cvcj0w2WNL0z4Sva8CWBkN7tY4hhWzDfX
 1ca3lSYDbYO3gFKaGx7mS1CnPNrmILrQN+Ti74/qMtCuYS4QuaXTdr96GyuSXJEQLOWgIqgGrr1
 aLwo2BRW6+V8zhcG2ifYJKWGFmP2OXnXuGervL48a9iy+Sk7E2WhGRn97JNIlSC9A7Tq863yhZZ
 QuaXjLK60kwK8/hYOcFhBDeO6/KEdrtGVzaEzo/9ncXngs69HXgzBZ/dpZ2LwfcOvamC+P8Y55S
 R6T7cmZkvjnE1QSCVLY4NHk1ay5MyPST+8bXWroPCcoOg==
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

Hi,

On 9/15/26 17:48, Christian König wrote:
> The blunt reality is that I don't have time to look into patches or bugs
> any more as it would be necessary. The same counts for Ray.
> 
> Natalie has been working on the dmem cgroup patches for TTM and agreed
> to take over looking more into TTM.
> 
> Arun is working in my team and already maintaining AMDs VRAM backend for
> TTM and the underlying buddy allocator.
> 
> Add Thomas as reviewer as well, better to have more eyes on that
> component.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Natalie Vock <nat@pixelcluster.dev>

Thank you for your work!

Best,
Natalie
> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b5a4e4b35cf..b6e58a138501 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9140,10 +9140,11 @@ F:	drivers/gpu/drm/drm_privacy_screen*
>   F:	include/drm/drm_privacy_screen*
>   
>   DRM TTM SUBSYSTEM
> -M:	Christian Koenig <christian.koenig@amd.com>
> -M:	Huang Rui <ray.huang@amd.com>
> +M:	Natalie Vock <nat@pixelcluster.dev>
> +M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
>   R:	Matthew Auld <matthew.auld@intel.com>
>   R:	Matthew Brost <matthew.brost@intel.com>
> +R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

