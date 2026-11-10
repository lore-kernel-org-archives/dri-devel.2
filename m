Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144A60A2603
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=UQifjXE1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FDA10F645;
	Tue, 10 Nov 2026 12:51:44 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4462110F645
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794315096;
 bh=LpW8bnbyKPQsIeY/hUiu+2QS/IzXdlLbZKVOxKpxbxU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UQifjXE1W2CoFx4GOn0ZY0QxRtwASNxchq9xILPVC9o8Tp+d2HErKE+aJhh/ZT9+N
 /BWYTr/kGhlkEux5VcKX4dJtj2Rg7DCJlu7BTyIQBdQ/RR+rcSEq0s45UmJHbIrYBI
 UuhHeiTwR800RTHvZLpbl5XX6H78Y+dD0rX44+YUh5Vn5W7NTQ6KlV9kK5zEW0RGO/
 NUBQLTBLxOgTuo77l6gLPKtqKp5fJZaUYLNiYDIBmgdwhprlY9vgGz2H+7NhCud4HL
 KhKZ/b5Yk2lh0mmvj9vJafpR31Q239MP1/yfkcjF77FY7JW0tLzgNnQElCnFjYozvt
 zTlqf61Wmqvug==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7BAA417E0634;
 Tue, 10 Nov 2026 13:51:36 +0100 (CET)
Message-ID: <c4ebe7c4-84c3-4c43-a149-cb04b18dc42c@collabora.com>
Date: Tue, 10 Nov 2026 14:51:36 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lucas Tanure <lucas.tanure@neat.no>
References: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
 <20261110-vc4-common-scramb-v4-6-eaa141a0da0f@collabora.com>
 <6044130c-8753-4928-990f-04f0ad43d9f1@igalia.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <6044130c-8753-4928-990f-04f0ad43d9f1@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Maíra,

On 11/10/26 2:11 PM, Maíra Canal wrote:
> 
> 
> On 09/11/26 21:13, Cristian Ciocaltea wrote:
>> Replace driver local scrambling logic with the newly introduced common
>> HDMI 2.0 scrambling support:
>>
>> - Advertise source-side scrambling capability by setting supported HDMI
>>    version based on the variant's max_pixel_clock.
>>
>> - Provide minimal .scrambler_{enable,disable} connector callbacks that
>>    only toggle the VC5 HDMI_SCRAMBLER_CTL register, while delegating
>>    sink-side SCDC programming and periodic status monitoring to
>>    drm_connector_hdmi_{enable,disable}_scrambling().
>>
>> - Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
>>    the .detect_ctx() path to drm_atomic_helper_connector_hdmi_hotplug()
>>    which internally calls drm_connector_hdmi_sync_scdc() to trigger a
>>    CRTC reset on reconnection.
>>
>> - Drop the local scrambling_work delayed workqueue and scdc_enabled
>>    flag, now tracked by the common drm_connector_hdmi layer, as well as
>>    the now unused output_{bpc,color_format} driver data members.
>>
>> No functional change intended.
>>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Reviewed-by: Maíra Canal <mcanal@igalia.com>

Thank you for your quick review!

> Feel free to push the series to drm-misc-next. Thank you!

Done.

Kind regards,
Cristian
