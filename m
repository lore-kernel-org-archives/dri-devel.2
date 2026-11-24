Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471E606A336
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=B2KRURmV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0915310F61F;
	Tue, 24 Nov 2026 14:43:36 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886AF10F60B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795531406;
 bh=+xcAFVyfZjCXw78iH5eaRb7q+NmVOvWAJooUbJ43vpY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B2KRURmVMnzlSfh/3guyYTv0j1AWRjCGZuabqe/B3OntHxn9B6dKAJlHu3SsD0SmX
 LVx7ce9h7L/4YDDzakQDdcWAV5/SuxSmQdgV9W4q9R3Q/+FadUwYCgwbpDXfwx/tTL
 YDOcAga1u2SeU8oIAoUCrt+yi1oenovqKr0WL994FrkADzRCCR7p1TGPJ3rSPs7lhg
 DohKMBp6gc3i+Tye2dAgBd45g8euDbjJaI5s2Yrds/IbAWjjsiKDXGXkqveYe/14NK
 idOJPckaCha8mz4XAFBjFkKfjPJgAsyYB5ypR+h02NteusfcQz7da1fm/ePzS4rn08
 aAf3b6kdgfguw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C90117E09ED;
 Tue, 24 Nov 2026 15:43:25 +0100 (CET)
Message-ID: <05cb7522-7894-43b1-8bf5-96a1a3792289@collabora.com>
Date: Tue, 24 Nov 2026 15:43:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/46] drm/mediatek: Export OVL Blend function
To: Daniel Stone <daniel@fooishbar.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com,
 Paul-pl Chen <paul-pl.chen@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-4-angelogioacchino.delregno@collabora.com>
 <CAPj87rOEtG9JqJsEZkatqrWUkerO9Xx93MBUrXXChJwCokE0Vw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAPj87rOEtG9JqJsEZkatqrWUkerO9Xx93MBUrXXChJwCokE0Vw@mail.gmail.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 15:30, Daniel Stone wrote:
> Hi Angelo,
> 
> On Tue, 14 Jul 2026 at 12:44, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>> +unsigned int mtk_ovl_get_blend_mode(struct mtk_plane_state *state, unsigned int blend_modes)
>> +{
>> +       unsigned int blend_mode = DRM_MODE_BLEND_COVERAGE;
>> +
>> +       /*
>> +        * For the platforms where OVL_CON_CLRFMT_MAN is defined in the hardware data sheet
>> +        * and supports premultiplied color formats, such as OVL_CON_CLRFMT_PARGB888
>> +        * and supports premultiplied color formats, such as OVL_CON_CLRFMT_PARGB8888.
>> +        *
>> +        * Check blend_modes in the driver data to see if premultiplied mode is supported.
>> +        * If not, use coverage mode instead to set it to the supported color formats.
>> +        *
>> +        * Current DRM assumption is that alpha is default premultiplied, so the bitmask of
>> +        * blend_modes must include BIT(DRM_MODE_BLEND_PREMULTI). Otherwise, mtk_plane_init()
>> +        * will get an error return from drm_plane_create_blend_mode_property() and
>> +        * state->base.pixel_blend_mode should not be used.
>> +        */
> 
> This hasn't been true since 9813e158d13d. I know this series predates
> that, and this is just existing code, but it's another instance of
> 'lie to userspace and fix stuff up behind its back' which we should
> get rid of ASAP please.

Hey Daniel,

thanks for that - it's coming just at the right moment, I think. :-)

Cheers,
Angelo
