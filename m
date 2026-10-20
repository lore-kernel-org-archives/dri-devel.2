Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B0606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=PcvDx0Dq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F74010F4F6;
	Tue, 20 Oct 2026 11:48:02 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 20 Oct 2026 11:47:55 UTC
Received: from mail-m118230.xmail.ntesmail.com
 (mail-m118230.xmail.ntesmail.com [115.236.118.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF7E10F4F6
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:47:55 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 51b70239a;
 Tue, 20 Oct 2026 19:42:46 +0800 (GMT+08:00)
Message-ID: <0a3dc505-43d2-471b-bd7c-222860544081@rock-chips.com>
Date: Tue, 20 Oct 2026 19:42:45 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] drm/bridge: analogix_dp: Use bridge->next_bridge
 instead of plat_data field
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
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
 Alim Akhtar <alim.akhtar@samsung.com>, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20261019085836.3065008-12-damon.ding@rock-chips.com>
 <202610201309.w3JSXlP5-lkp@intel.com> <3789853.R56niFO833@diego>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <3789853.R56niFO833@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1591f009e03a8kunmb99823d738c545
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUhXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZShkaVktIQh9IGUsaSRgZTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0JMVUhJTE
 1CVU9VSEtLSlkG
DKIM-Signature: a=rsa-sha256;
 b=PcvDx0DqHkOKPqjTQ+WfmUYCXD9mwvhFrc7mSaBffIry2c4fUYbdXMX59bNKWZBcDiTaCQ/YNMiQcmhD7Zsd1KQbLmtLq7Ltd9XK3HumvYifhWq4A4Ftt4y/jY42N+ztDwlpKKLycWUI8mg322eGJ0P3DLzIVv1imnkclT3bR5E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=0fP5WnkQ/jEXyj1gQYTYNTXqYm8pVqxjqPzKb7O0M40=;
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko,

On 10/20/2026 6:38 PM, Heiko Stübner wrote:
> Am Dienstag, 20. Oktober 2026, 07:36:21 Mitteleuropäische Sommerzeit schrieb kernel test robot:
>> Hi Damon,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on drm-misc/drm-misc-next]
>> [also build test ERROR on drm/drm-next next-20261019]
>> [cannot apply to daeinki-drm-exynos/exynos-drm-next linus/master v7.3]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Damon-Ding/drm-bridge-analogix_dp-Return-bitmask-from-analogix_dp_get_irq_type/20261019-165823
>> base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
>> patch link:    https://lore.kernel.org/r/20261019085836.3065008-12-damon.ding%40rock-chips.com
>> patch subject: [PATCH v4 11/14] drm/bridge: analogix_dp: Use bridge->next_bridge instead of plat_data field
>> config: nios2-randconfig-1000-20261020 (https://download.01.org/0day-ci/archive/20261020/202610201309.w3JSXlP5-lkp@intel.com/config)
>> compiler: nios2-linux-gcc (GCC) 11.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261020/202610201309.w3JSXlP5-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202610201309.w3JSXlP5-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     nios2-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_aux_done_probing':
>>>> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1669:(.text+0xb80): undefined reference to `devm_drm_of_display_mode_bridge'
>>>> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1669:(.text+0xb80): relocation truncated to fit: R_NIOS2_CALL26 against `devm_drm_of_display_mode_bridge'
> 
> I guess the Rockchip kconfig for the Analogix-DP also needs a
> 
> 	select DRM_OF_DISPLAY_MODE_BRIDGE
> 
> similar to exynos and imx.
> 

Will fix in v5. Also refine patches 9-13 as suggested by sashiko.

Best regards,
Damon

