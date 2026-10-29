Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5089606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Vhl8EtaG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E0A10E7C2;
	Thu, 29 Oct 2026 10:18:22 +0000 (UTC)
Received: from mail-m10224.netease.com (mail-m10224.netease.com
 [154.81.10.224])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D501112195
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:18:16 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 52cbb8f47;
 Thu, 29 Oct 2026 18:18:12 +0800 (GMT+08:00)
Message-ID: <503d1a69-4e9b-4039-9e6e-3f1cc14cb493@rock-chips.com>
Date: Thu, 29 Oct 2026 18:18:11 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/18] Add HPD support for Rockchip Analogix DP
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <CGME20261027133735eucas1p217fbce1514e5d83c14e64d8d0b1ae867@eucas1p2.samsung.com>
 <20261027132810.1746118-1-damon.ding@rock-chips.com>
 <c451af42-2e79-43fd-b66e-08a2b01283c6@samsung.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <c451af42-2e79-43fd-b66e-08a2b01283c6@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1872acf1203a8kunmcca4554e4f0ec9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTRpDVkhIGk0dS0MaTh5PQ1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5KVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Vhl8EtaGol9ECLa9bh5/0LlcIkN4b9YV3O7/FJ/kRkU/+QfhM5JW1YSwP6V9ITwPs/JfioMrXCiT5XfHVNJAQI/oRMi6H8LUoKiOfV8FfeFLnZO4/6IzPyyv/zc+LQqKgD5UhCJpN4mLXMJdImAjVPpNlL1Pwc5IwDfZD4h6HUA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=rd623ZTzi7rpegKU0r+iCQY9Cdo6i2YNjY/ptU34dog=;
 h=date:mime-version:subject:message-id:from;
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 10/29/2026 4:29 PM, Marek Szyprowski wrote:
> On 27.10.2026 14:27, Damon Ding wrote:
>> This series improves the HPD (Hotplug Detect) interrupt handling in
>> the Analogix DP driver to enable reliable native HPD pin detection on
>> Rockchip platforms, and introduces platform-specific HPD detection
>> schemes with fine-grained interrupt control.
>>
>> On Rockchip platforms, the Analogix DP native HPD pin IRQ requires the
>> DP controller to remain powered, clocked and initialized to generate
>> plug/unplug interrupts. The previous driver enabled/disabled IRQ during
>> bridge enable/disable, which left no HPD detection when the display
>> pipeline was inactive. Additionally, the interrupt mute/unmute/clear
>> routines operated on all HPD interrupt bits unconditionally, lacking
>> the granularity needed for per-event control.
>>
>> The series reorganizes IRQ and pm_runtime management into bind/unbind,
>> adds IRQF_ONESHOT to eliminate read-modify-write races on interrupt
>> mask registers between hardirq and threaded handlers, converts the
>> interrupt type detection to a bitmask-based scheme for fine-grained
>> mute/unmute/clear operations, and configures Rockchip platforms to use
>> the HOTPLUG_CHG interrupt with a 2ms HPD deglitch setting for better
>> stability.
>>
>> Furthermore, the next bridge is now resolved into bridge->next_bridge
>> instead of the platform data field, the forced connected-status logic
>> is restricted to panel endpoints based on the bridge chain, and HPD
>> events from downstream bridges (e.g. display-connector with hpd-gpios)
>> are handled through the .hpd_notify callback.
>>
>> Tested on RK3576 with both native HPD pin and GPIO HPD configurations.
>>
>> Native HPD pin mode:
>>
>>    &edp {
>>        status = "okay";
>>        pinctrl-names = "default";
>>        pinctrl-0 = <&edp_txm0_pins>;
>>    };
>>
>> GPIO HPD mode:
>>
>>    &edp {
>>        status = "okay";
>>        pinctrl-names = "default";
>>        pinctrl-0 = <&edp0_hpd>;
>>        hpd-gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
>>    };
>>
>>    &pinctrl {
>>        edp {
>>            edp0_hpd: edp0-hpd {
>>                rockchip,pins = <4 RK_PC1 0 &pcfg_pull_none>;
>>            };
>>        };
>>    };
>>
>> Display-connector mode (DP connector without HPD GPIO):
>>
>>    &edp_out_conn {
>>        remote-endpoint = <&dp_con_in>;
>>    };
>>
>>    dp-con {
>>        compatible = "dp-connector";
>>        label = "DP OUT";
>>        type = "full-size";
>>
>>        port {
>>            dp_con_in: endpoint {
>>                remote-endpoint = <&edp_out_conn>;
>>            };
>>        };
>>    };
>>
>> Display-connector mode (DP connector with HPD GPIO):
>>
>>    dp-con {
>>        compatible = "dp-connector";
>>        label = "DP OUT";
>>        type = "full-size";
>>        pinctrl-0 = <&edp0_hpd>;
>>        pinctrl-names = "default";
>>        hpd-gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
>>
>>        port {
>>            dp_con_in: endpoint {
>>                remote-endpoint = <&edp_out_conn>;
>>            };
>>        };
>>    };
>>
>> All four configurations detect cable plug/unplug events correctly.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Snow, Peach-Pit and Peach-Pi Chromebooks still work fine with this patchset.
> 

Thanks for your testing and confirmation.

Best regards,
Damon

