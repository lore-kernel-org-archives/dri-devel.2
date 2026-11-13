Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C31606A89F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=jvZOX/3D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956CD10E5BE;
	Fri, 13 Nov 2026 01:15:47 +0000 (UTC)
Received: from mail-m1060.netease.com (mail-m1060.netease.com [154.81.10.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B30110E5BE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:15:41 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54833a7f1;
 Fri, 13 Nov 2026 09:15:37 +0800 (GMT+08:00)
Message-ID: <385a67f0-e5cd-4dba-9b9c-5b766462c6c0@rock-chips.com>
Date: Fri, 13 Nov 2026 09:15:36 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: analogix_dp: use devm_phy_optional_get()
 for the DP PHY
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jun Yan <jerrysteve1101@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20261110023721.2014061-1-jerrysteve1101@gmail.com>
 <DMTCFJVH99S4.27AWO8PN3ZPK7@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DMTCFJVH99S4.27AWO8PN3ZPK7@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1d27973cf03a8kunmd978f5f73efad
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE8dVklCGUsdHUlOHxpMSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=jvZOX/3D/bNlgPloRPtSZPL08WTVzeWxnVwbDnGy8297Sz/6soz2u/dTFqW4w+a41XTqz6uLGOZ9RLT5PHX3rMqY8t3BrnpMI8kS16+hZE1blf2Q+umzxuCX2+s7f5zl7H+iAH+TKYFTwJAG/fnDL0/c44ttKN2KyhDsV7sbEgc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=9cu9IwiuATsWuuheJo3Q86aMZzHyohT9TpnVIAb0zIU=;
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 11:39 PM, Luca Ceresoli wrote:
> Hello,
> 
> On Tue Nov 10, 2026 at 3:37 AM CET, Jun Yan wrote:
>> The DP PHY is optional: the Rockchip RK3399 eDP controller (used as the
>> internal eDP port) has no separate PHY device and relies on its built-in
>> PHY, which is programmed directly through the GRF registers, so its DT
>> node carries no "phys"/"phy-names" property.
>>
>> Requesting the PHY with devm_phy_get() therefore returns -ENODEV (or
>> -ENOSYS when CONFIG_GENERIC_PHY is disabled) and the driver logs a
>> misleading "no DP phy configured" error at probe time before falling back
>> to a NULL phy.
>>
>> Use devm_phy_optional_get() instead, which returns NULL when the PHY is
>> absent and otherwise behaves identically, and drop the manual -ENODEV/
>> -ENOSYS handling. This also removes the spurious error message.
>>
>> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
>> Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>> Changes in v3:
>>    - Add missing changelog entries and reference links
>>    - Link to v2: https://lore.kernel.org/dri-devel/20261013134659.335829-1-jerrysteve1101@gmail.com/
>>
>> Changes in v2:
>>    - Added comments to explain the changes made.
>>    - Link to v1: https://lore.kernel.org/dri-devel/20260924020417.868588-1-jerrysteve1101@gmail.com/
>>
>>   .../drm/bridge/analogix/analogix_dp_core.c    | 22 ++++++-------------
>>   1 file changed, 7 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 6df6963740d2..637b1bff0f6c 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -1426,21 +1426,13 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>>   	if (ret)
>>   		return ERR_PTR(ret);
>>
>> -	dp->phy = devm_phy_get(dp->dev, "dp");
>> -	if (IS_ERR(dp->phy)) {
>> -		dev_err(dp->dev, "no DP phy configured\n");
>> -		ret = PTR_ERR(dp->phy);
>> -		if (ret) {
>> -			/*
>> -			 * phy itself is not enabled, so we can move forward
>> -			 * assigning NULL to phy pointer.
>> -			 */
>> -			if (ret == -ENOSYS || ret == -ENODEV)
>> -				dp->phy = NULL;
>> -			else
>> -				return ERR_PTR(ret);
>> -		}
>> -	}
>> +	/*
>> +	 * RK3288/RK3399 use Analogix DP controller built-in PHY,
>> +	 * no extra PHY configuration is required.
>> +	 */
>> +	dp->phy = devm_phy_optional_get(dp->dev, "dp");
>> +	if (IS_ERR(dp->phy))
>> +		return ERR_CAST(dp->phy);
> 
> The original code ignbores -ENOSYS, devm_phy_optional_get() does not. So,
> either -ENOSYS was just impossible, or this patch potentially changes the
> behaviour.
> 
> Can you elaborate on that?
> 
> 

You are right, this is really a valid concern.

If CONFIG_GENERIC_PHY is disabled, the old code could still proceed and 
keep the driver probing, while the new version would return an error 
directly.

It should be better to keep the -ENOSYS handling to preserve the 
original behavior.

Best regards,
Damon

