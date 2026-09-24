Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FB7C9831C
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C3E10E0F6;
	Thu, 24 Sep 2026 11:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D2f0AEAm";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA55610E0F6
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 11:13:03 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so1348764a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790248383; x=1790853183; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xajPQk8GjdXK5kaUdC9KQJ19YcliIXFOaF4kzScKofU=;
 b=D2f0AEAmsQ37/jtYgvje1jrPPqFyPuDobEwthR5OJEts223kx5uidRoIre0uRKpt3o
 BWdMpSz0etxmbUv9dTYsNj1xcbryB5yGS6H/uQxigujymx14UkQxqccNICHqS6xULdk5
 un5XKA+qFQXpNTOX3WZfBZDm5lJTDJ5ctuTYNG+Y7gdp6/HO8WUt1DHVsKlh5CS/FQns
 c4j0Sb1k05HF7PXRvRvEw5J0vVpIc4i/kiqiwA/fwzGjTFD0csaLFk+Rt88gzwqam7gd
 g++FrOJZx8M/Cn7WvUUkQwk6z3k54eVnad6xKy4nRvoJ/7ON+MpwvWDsuCCVOBKuH7O2
 4PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790248383; x=1790853183;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xajPQk8GjdXK5kaUdC9KQJ19YcliIXFOaF4kzScKofU=;
 b=n5ygNMv6CtwTgnM1BrEql6tc+NGyLznMXuAod6QgDFzeRt53xezXbRVpiXUybufx5u
 foYPASIReo3zuPFquKyK83myg7Gq3AEZ/J0BWHBM1mO2/12DGuhYnfWcSakvfiAf0vjt
 4Nu2tmms1+DOKP+JRKQZZic/EKO45MmojXN/aA9qBP97i8w9JlhRRj6KXGS/ddqBqgj+
 lZQW/U9z0e7HjheLYs/6aUSvkRvlECf6rYWIzZn0IMqmWftI+hdoPx1KbWkiAsIADT8S
 g4oRzuNOhEk9XCTLIouvOUCze4Wnqy7PcyACH1bp73ptIEB3yplWBvJtdgV6ZJiVVGHS
 DiKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByR0fgWAL3y+pwMtlQQRKJkdUZlnQr6f/npZUrEMWuqsjnBxLzjBtIS4Ll1ukrVyFlThuS32W/ynSA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lRnt34roF80pmkgJJ6Qy1HTBbdYmhGlvWjbNqhQjtVMPuVhfkh
 L9LM/D6FBx7KgADGG3d2jv2r/u7KhRxaoWXWi/ffK8wKIYCaQT0OQvrY
X-Gm-Gg: AYBFou1nF0Tcdymxad3i/9JPY8PmPHvcbIAP6Fg6jOIU42gDNuChwqFwWa5nMGFKN6e
 vy1nG4q8arO/yeErfhSWuTSXrmpYG4bC+p8WuPmqbm3/TiuM0BvzxSDJfIJMs55sFsKbnNhMauO
 ODow/0DmhIacZgw9bsFiP9ZAuhsctv5nyH4jo4o76FDX7dM7RkyTV7x2hsqLqHBOEmkfslVVRJT
 J9R/81o/DzTXUHSsOBl8BSNN1SJLAXSpM7A9+jEuKWjtP0iKuoyw+UGa49d/fJ/7q9YVmOrVlrG
 9zyg4NO/F9eDpTFyZnVAFeyZH0Grn/X64ZEC0NafGR2n7Y2kIlLxs7uVGrUqAQB1ZYZgaFL4k2U
 Q8CSB1KUusbIkA+hz13w1csfYfbgIe5YjUBPC5nPfDpLWKwFEOA1thOTKdGfSDSNEl4HcvxkO4l
 8daK8xMjdUAdC9OwtWd4IbNnder7W20ceMCt4/XFYhqqatoGo21gMUdH7SFAi2qbmvJ9DujDEv7
 gdjXspTgiGxj/UKN+TtzEYzjC/xKB2RMQ==
X-Received: by 2002:a17:90b:314e:b0:39e:5ade:f9de with SMTP id
 98e67ed59e1d1-3a098b431dbmr1903170a91.26.1790248378423; 
 Thu, 24 Sep 2026 04:12:58 -0700 (PDT)
Received: from arch.localdomain (123202092053.ctinets.com. [123.202.92.53])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0974ec5dfsm4399478a91.3.2026.09.24.04.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 04:12:58 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: damon.ding@rock-chips.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org, heiko@sntech.de,
 jernej.skrabec@gmail.com, jerrysteve1101@gmail.com, jonas@kwiboo.se,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de
Subject: Re: [PATCH RSEND] drm/bridge: analogix_dp: use
 devm_phy_optional_get() for the DP PHY
Date: Thu, 24 Sep 2026 19:12:49 +0800
Message-ID: <20260924111251.936444-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a0754d11-d88b-4dda-972f-7c696a037bc2@rock-chips.com>
References: <a0754d11-d88b-4dda-972f-7c696a037bc2@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

> On 9/24/2026 11:24 AM, Damon Ding wrote:
> > Hi Jun,
> > 
> > On 9/24/2026 10:04 AM, Jun Yan wrote:
> >> The DP PHY is optional: the Rockchip RK3399 eDP controller (used as the
> >> internal eDP port) has no separate PHY device and relies on its built-in
> >> PHY, which is programmed directly through the GRF registers, so its DT
> >> node carries no "phys"/"phy-names" property.
> >>
> >> Requesting the PHY with devm_phy_get() therefore returns -ENODEV (or
> >> -ENOSYS when CONFIG_GENERIC_PHY is disabled) and the driver logs a
> >> misleading "no DP phy configured" error at probe time before falling back
> >> to a NULL phy.
> >>
> >> Use devm_phy_optional_get() instead, which returns NULL when the PHY is
> >> absent and otherwise behaves identically, and drop the manual -ENODEV/
> >> -ENOSYS handling. This also removes the spurious error message.
> >>
> >> Assisted-by: Claude:deepseek-v4-flash
> >> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> >> ---
> >>   .../gpu/drm/bridge/analogix/analogix_dp_core.c | 18 +++---------------
> >>   1 file changed, 3 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/ 
> >> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >> index 18e76d1e78e1..28eb668d3e3f 100644
> >> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >> @@ -1427,21 +1427,9 @@ analogix_dp_probe(struct device *dev, struct 
> >> analogix_dp_plat_data *plat_data)
> >>       if (ret)
> >>           return ERR_PTR(ret);
> >> -    dp->phy = devm_phy_get(dp->dev, "dp");
> >> -    if (IS_ERR(dp->phy)) {
> >> -        dev_err(dp->dev, "no DP phy configured\n");
> >> -        ret = PTR_ERR(dp->phy);
> >> -        if (ret) {
> >> -            /*
> >> -             * phy itself is not enabled, so we can move forward
> >> -             * assigning NULL to phy pointer.
> >> -             */
> >> -            if (ret == -ENOSYS || ret == -ENODEV)
> >> -                dp->phy = NULL;
> >> -            else
> >> -                return ERR_PTR(ret);
> >> -        }
> >> -    }
> > 
> > It should be better to add some comments here:
> > 
> > /*
> >   * Exynos5/RK3288/RK3399 use Analogix DP controller built-in PHY,
> >   * no separate PHY configuration is needed.
> >   */
> 
> Well, I think it should be fixed to:
> 
> /*
>   * RK3288/RK3399 use Analogix DP controller built-in PHY,
>   * no extra PHY configuration is required.
>   */
> 
> The Exynos5xxx case may be more complex.
> 

Thanks for the review. I will add the comments in the patch and send v2 soon.

> > 
> >> +    dp->phy = devm_phy_optional_get(dp->dev, "dp");
> >> +    if (IS_ERR(dp->phy))
> >> +        return ERR_CAST(dp->phy);
> >>       dp->clock = devm_clk_get(&pdev->dev, "dp");
> >>       if (IS_ERR(dp->clock)) {
> > 
> > With the comment added:
> > Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
> > 
> > Best regards,
> > Damon
> > 



