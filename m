Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5845606D81F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WttVKCZ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7B410E1B8;
	Thu,  5 Nov 2026 13:04:35 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717BC10E1B8
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793883867;
 bh=IBsoZ1Vp7gsgzVEtbu51c9eHaEQR+2eUZSh26ar6Ris=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WttVKCZ8v63kNXP9SLbHEi8Y0ZpduE4V1tcnKbCSthLJxNsH2uQDloZRquWB9sc9I
 +pPRAb06OWgbC4MsbcTO+tOTGaZWU+u+0YBKWfxG+QtDZ98ymzX8cFXI/w5IiOQXfD
 eAr9YLKMlZvTOHSE8N3mNu0yR8sisg+VEsz6ibB6BdIZ6ycriCirAFT+S8QjxBSJn2
 Zht9YlCSULNsA4kb9Ovikn5EKr5vC3rUyF6uBeSnxZcSp+CGgWUvm+9/dx+9alfQr6
 YpQ3OJlpXFqz1XaA/eREQOt+Ht3ZMr/nNmAN7gJ9X4aJdrQATmJKXueSSt4Nb8aGhN
 F2/e0M3TtztnA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E16A617E05D6;
 Thu, 05 Nov 2026 14:04:25 +0100 (CET)
Message-ID: <81fbb960-abde-44ea-82ab-3adc054da836@collabora.com>
Date: Thu, 5 Nov 2026 15:04:25 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/15] Support 10-bit YUV422 and 8/10-bit YUV420 color
 format on DW HDMI QP
To: Daniel Stone <daniel@fooishbar.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Daniel Stone <daniels@collabora.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <CAPj87rMQdE3eeUxGSb4oQfB4Adry6UV8CvhGoTKtdKGQHdSo4Q@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAPj87rMQdE3eeUxGSb4oQfB4Adry6UV8CvhGoTKtdKGQHdSo4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Daniel,

On 11/5/26 2:25 PM, Daniel Stone wrote:
> Hi Cristi,
> 
> On Thu, 5 Nov 2026 at 01:01, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>> Changes in v6:
>> - Added new vop2 patch "Disable core clocks before dropping runtime PM
>>   reference" (Sashiko)
>>
>> Changes in v5:
>> - Added new patch "drm/rockchip: dw_hdmi_qp: Do not mask error code in
>>   atomic_check()" to fix a pre-existing issue reported by Sashiko
>>
>> Changes in v3:
>> - Updated patch 3 to skip any hardware programming in the callbacks
>>   gated by drm_atomic_helper_commit_planes() after powering down VOP2 on
>>   an atomic_enable() error (Sashiko)
>> - Ensured VBLANK events are sent immediately when atomic_enable() fails,
>>   hence preventing userspace processes waiting for the page flip
>>   completion to hang indefinitely (new patch 4, Sashiko)
>>
>> Changes in v2:
>> - Addressed several issues reported by Sashiko
>>   * Reset AXI before detaching the IOMMU domain, to close a theoretical
>>     window where stale or in-flight DMA transactions could fault or
>>     access memory untranslated after the domain is detached (patch 6)
>>   * Fixed resource leak on vop2_enable() error path (new patch 2)
>>   * Balance state on atomic_enable error paths (new patch 3)
>>   * Avoided division by zero when computing max_dclk (new path 4)
>>   * Fixed VOP2_MAX_DCLK_RATE overflow on 32-bit (new patch 5)
> 
> I think everything in here should now be solidly reviewed. 

Thanks a lot for checking this out!

> But if this> series keeps on collecting unrelated patches until Sashiko decides all
> of VOP2 is bug-free, we will never get this series merged. Could we
> please keep this series focused on the useful bits at the end, and not
> keep on adding speculative new Sashiko-pleasing as artificial
> dependencies?

Yeah, sorry for that.  I'll stop here with regard to addressing further Sashiko
findings, unless there is really something wrong introduced by this series
(which doesn't seem to be the case).

Regards,
Cristian
