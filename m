Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA86CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 20:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1835710E5D1;
	Thu, 28 May 2026 20:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=al2klimov.de header.i=@al2klimov.de header.b="Isld5dKP";
	dkim-atps=neutral
Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6844810F57D
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=RwO1U3J9gzU/
 IEjAvU0oaORmBpZMvsulP2X03RvaRpQ=;
 h=in-reply-to:from:references:to:
 subject:date; d=al2klimov.de; b=Isld5dKPnYwVyhir8n6NCC165/jv5YI++KTB63
 Rvo5mCPUn+FDb8kv1d2QuA62DOLL+uX77PRtKFiAW+P2fUNBFRC9cO663xNr1xeUvgPPGH
 wtBMOVAVWghoHMEas6PNe9Fk5AgZyDWaVNGl+SJXn+SrqlgVRhiElLL8hBpG02jgTyXvJs
 1xU/nLpuROCDDbHjxClg7+wXkhYabGHOkqrOs8iPgYtWKsJ/8i+fgxeFGCkqrYmvkpAh2F
 tyC0ENPGzqBaIjCzeGzA1NF02OmmCTautrq3Z8KgAgUrgvvD6YWMUwYhQUgS7II2aXO60k
 4G6nN1l8amJTMxgn0m5FovZA==
Received: from [192.168.0.101] (88.215.123.80.dyn.pyur.net [88.215.123.80])
 by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 4569e504
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Thu, 28 May 2026 18:54:18 +0000 (UTC)
Message-ID: <5642dd71-01ad-4db2-b0b8-5431298b39a1@al2klimov.de>
Date: Thu, 28 May 2026 20:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: fix krealloc() memory leak
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260526184105.18962-1-grandmaster@al2klimov.de>
 <20260526184105.18962-5-grandmaster@al2klimov.de>
 <2b602ec6-d563-4fa0-a0c5-89b97a46abf9@igalia.com>
Content-Language: en-US
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
In-Reply-To: <2b602ec6-d563-4fa0-a0c5-89b97a46abf9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 20:08:24 +0000
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



On 5/28/26 20:17, Maíra Canal wrote:
> Hi Alexander,
> 
> LGTM, but a small styling nit:
> 
> On 26/05/26 15:41, Alexander A. Klimov wrote:
>> Don't just overwrite the original pointer passed to krealloc()
>> with its return value without checking latter:
>>
>>      MEM = krealloc(MEM, SZ, GFP);
>>
>> If krealloc() returns NULL, that erases the pointer
>> to the still allocated memory, hence leaks this memory.
>> Instead, use a temporary variable, check it's not NULL
>> and only then assign it to the original pointer:
>>
>>      TMP = krealloc(MEM, SZ, GFP);
>>      if (!TMP) return;
>>      MEM = TMP;
>>
>> Fixes: 6d45c81d229d ("drm/vc4: Add support for branching in shader validation.")
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>   drivers/gpu/drm/vc4/vc4_validate_shaders.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
>> index d48cf76983c0..af48758592f9 100644
>> --- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
>> +++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
>> @@ -291,14 +291,14 @@ static bool require_uniform_address_uniform(struct vc4_validated_shader_info *va
>>       uint32_t o = validated_shader->num_uniform_addr_offsets;
>>       uint32_t num_uniforms = validated_shader->uniforms_size / 4;
> 
> Declare the variable here.

Strange...
It comes already directly after num_uniforms, doesn't it?
At least when I apply my patch to Linus' master.
