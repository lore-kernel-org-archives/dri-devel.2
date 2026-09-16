Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8163AC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB1B10E5C7;
	Wed, 16 Sep 2026 10:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="lmODPOKr";
	dkim-atps=neutral
Received: from smtpout9.mo536.mail-out.ovh.net
 (smtpout9.mo536.mail-out.ovh.net [51.210.91.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A15A10E5AF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:35:19 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hlFdc21vVz880h;
 Wed, 16 Sep 2026 10:35:16 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <arunpravin.paneerselvam@amd.com>; Wed, 16 Sep 2026 10:35:16 +0000 (UTC)
Received: from mta10.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.201])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hlFdc168Sz1xtp;
 Wed, 16 Sep 2026 10:35:16 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.9])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta10.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id A8732781C1E;
 Wed, 16 Sep 2026 10:35:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0075e4818bc-688d-4982-a32e-6e16fa858dde,
 69B76013C106EEA375DAA2C64D98DF65BC6C8E4B) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <5e301f2e-730c-479a-890d-7ed6044b8a1c@pixelcluster.dev>
Date: Wed, 16 Sep 2026 12:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 christian.koenig@amd.com, ray.huang@amd.com,
 arunpravin.paneerselvam@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260915154804.605772-1-christian.koenig@amd.com>
 <a3c94fcf0029e7f257a0219532d906643846ffd1.camel@linux.intel.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <a3c94fcf0029e7f257a0219532d906643846ffd1.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8134626828561047868
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGglG5C7iKN+LXavtK7wlbmmkf4F/ObYq9HxSCoL2A5ZMFapu7bWDJwcVtau5SozmeyW9OkZUGBc54FdE5LfCQ9+7rP1QEij5VZBTLhL2FpmK/PgFTo022WCwiA1vkWSlvf8pFgT8+0irNsrZ4Hps+PAJyPcTn6b0GTKZ+UqM47ZQGzEqheWTpf+E6uB2fqcPyhyI2aGrC8HiqI0CiCdPyWc9rXjC3J+g97YQrSocvhmiq39dsG+SFJbQpk3Jookrce8Yjy7odG13oeVC1IJ7VsQDGEJjzMq1FJtQE0Y0Kd8a6Zd7uojJD5BvAyKgsw4IwU05W/x6RRLiWOQsJKpjEip/JxggW9ydd5k/mjqRcx303fOFUo70Lz7FGYgHUIE6J+XfwF9fJiy1cp+m9TiMiOXh2LMZGh6NrkkpVoDmoY53TrbzS7jBSf786C7ak+RW8HsJabmgMn6LHonxNnjFdpwzkDcFVosry8gMjeXqR8Ui7rEqXfwmxoCTAtg0yMXT5FINQ+4hmcGQkyIknSNFrqKx7/NLlYoQUCu5COJX4oblLJKF2MRPK6zh09RpmgUZq7JAu4/V3ieOSseaef485dua5MSBZ3uByu/W/W3gL5a4DzUcWxoiR7zQSZxNohITi9Yh8ZHw3ac6Wk2n4Lh+9muCR2mOampUpMYc+eRB/K8w
DKIM-Signature: a=rsa-sha256; bh=A+22pfm5bN0jvueOmz1GvYenM8HgxlTvocVz96fbruU=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1789554917; v=1;
 b=lmODPOKrFz/jQ3FRlII/7+3fHr98CXYvizu/nmzb1pSZgqi9qDzIRxEquk3EF7XcLbBOwfH9
 92a/g+8hQSIiwYx7fhh2l7s23EXc3Vs4pyK16HfIO2MIziSW4dlINKIW6bQo5tiZTMeqy42B/vz
 QyVRqZFoRsixoWd8Xo5wlwi4kcYTKjjoioNk4awDk9Xuor2NIBkP3VP3GSCD6pMsxbnSLtheWcI
 7KB0JHbAxQpXnwh38ZQkM5shczRwD1v3TrOFDFKPdYeZdw6sCd3FwZ+KznrqgpDATyKg1wIN1CJ
 eZhEV/LNzeOPtGkOkZV2BrotClfjoshrvAku91CofQHVQ==
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

On 9/16/26 11:44, Thomas Hellström wrote:
> On Tue, 2026-09-15 at 17:48 +0200, Christian König wrote:
>> The blunt reality is that I don't have time to look into patches or
>> bugs
>> any more as it would be necessary. The same counts for Ray.
>>
>> Natalie has been working on the dmem cgroup patches for TTM and
>> agreed
>> to take over looking more into TTM.
>>
>> Arun is working in my team and already maintaining AMDs VRAM backend
>> for
>> TTM and the underlying buddy allocator.
>>
>> Add Thomas as reviewer as well, better to have more eyes on that
>> component.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   MAINTAINERS | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5b5a4e4b35cf..b6e58a138501 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9140,10 +9140,11 @@ F:	drivers/gpu/drm/drm_privacy_screen*
>>   F:	include/drm/drm_privacy_screen*
>>   
>>   DRM TTM SUBSYSTEM
>> -M:	Christian Koenig <christian.koenig@amd.com>
>> -M:	Huang Rui <ray.huang@amd.com>
>> +M:	Natalie Vock <nat@pixelcluster.dev>
>> +M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
>>   R:	Matthew Auld <matthew.auld@intel.com>
>>   R:	Matthew Brost <matthew.brost@intel.com>
>> +R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>   L:	dri-devel@lists.freedesktop.org
>>   S:	Maintained
>>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> 
> Acked-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> @Natalie, @Arun Do you have a presence on dri-devel IRC? If so, Nicks?

Yes, I have the nick "pixelcluster".

> 
> Also what is your stance on merging pages to TTM?
> 1) Requiring an explicit maintainer ack, or
> 2) an R-B from one of the reviewers/maintainers and no concerns raised
> within reasonable time?

I think my preference would more or less be 2). That is, if for some
reason no maintainer answers, after some time the patches should be ok
to merge (but if a maintainer does explicitly ack/R-b the patch it can
be merged sooner). I'll try my best to not leave patches unanswered so
hopefully 2) stays a rarity :)

> 3) drm-misc as default merge repo?

Sure, why not? Basically like it's been so far as well, right? It didn't
seem to me like the patch volume for TTM is particularly large at least
so far, so something like a separate branch might not be worth the
hassle.

Best,
Natalie

