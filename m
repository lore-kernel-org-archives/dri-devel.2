Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CEB606A334
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=C+S2LwEI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D6710E14B;
	Wed, 25 Nov 2026 15:47:58 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C4010E14B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:47:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 916D84E41774;
 Wed, 25 Nov 2026 15:47:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5D21460480;
 Wed, 25 Nov 2026 15:47:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8064511E6A143; Wed, 25 Nov 2026 16:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795621665; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YUSjgUN/6KwEjmXPfb+omVKhEOcotcQptSpIZk5o8Og=;
 b=C+S2LwEIUFJ+PTX3f9IkDYUibHEsDLM7RogBuUXLjinyt0WjiCx+i23061HWuwpXWe38ma
 w5AsDVpNowR+gtIF9h9G6qc7J4jYSq/sk/a+WKE2i0jugap5pfYym03oixnuMV5aeDE+fe
 4fUEja2SKvSYXe5Rbch0F6gjMxLxFHJkqAtifqTnsASakiFo1uwo9iQOaudND7403nLMZo
 EbgnfE1DLKtCriM17wadIHjr2V/AbluOuHc01w6pE/FisAVKX6zB6/4l2nlQh011fo0BQ/
 Cai1IOR9JNlyWteTB/KzCHygtZviKVrr5HJHnxfDw/OADItzj4SccxRdTOqkdw==
Message-ID: <02c97b4d-778f-4657-bcb4-dfb9bd98bba9@bootlin.com>
Date: Wed, 25 Nov 2026 16:47:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] drm/vkms: test sRGB and inverse sRGB LUTs using
 more samples
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-11-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-11-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 21:18, Leandro Ribeiro wrote:
> We're currently using srgb_eotf.lut_length samples in
> vkms_color_srgb_inv_srgb(). This does not exercise any points that are
> not in the forward sRGB LUT, although it exercises points that are not
> in its inverse.
> 
> Let's test with more samples, to also exercise points that are not in
> the forward sRGB LUT.
> 
> We chose 4096 samples. LUT inputs are u16, so we could have up to 65536
> samples. LUT sizes are usually not higher than 512, so with 4096 we have
> at least 8 samples between each LUT point.
> 
> We can see a minor error bump with this change. In the next commits we
> replace such LUTs with non-uniform optimal ones to reduce the error.
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
