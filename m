Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE27CD13DF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914C510E8EE;
	Thu, 30 Apr 2026 17:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wp.pl header.i=@wp.pl header.b="l5JdEpV8";
	dkim-atps=neutral
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F57310E9D4
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:56:38 +0000 (UTC)
Received: (wp-smtpd smtp.wp.pl 24130 invoked from network);
 30 Apr 2026 15:56:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
 t=1777557395; bh=SW+P/aqOKFVhQ8Z8DAk2rSXIHjqqBZ7tc0D+4+VkfDY=;
 h=Subject:To:Cc:From;
 b=l5JdEpV81+Xrs7IUUgQgWLY8Ta7swWzaGUWZt55DM1xfOtS0XKJ4F6Q42c9i+8irH
 iHKrkETnaYU5kKBCX95F/YiIvywVc3xSAtgO6JcNG+Rpo+SXTOvsT3v8YO1IPcUUfa
 0CyXm37BjsnpUjvVQFauJUnvuOHXrphx5hNOwPrlLqe71llKzGnXT3a6jhncN/xNcd
 Wf57IjoUZFC669v9RwXtXOFj4K4bEU4k0bhuP5QmkAJ7oI1e9oJUNK1gKmsYNPKyyV
 Qwc9OXx4DSIhgeNvZGOqAGgOj6eY1GR6PmaUWo/a1GdoC44rb9HAaPq4gpqfey5um+
 YvdRc+q3TI9SQ==
Received: from host18560247242.static.ssm.silesia.pl (HELO [192.168.1.120])
 (adamszyma@wp.pl@[185.60.247.242])
 (envelope-sender <adamszyma@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
 for <neil.armstrong@linaro.org>; 30 Apr 2026 15:56:35 +0200
Message-ID: <294e94dc-d797-4ab6-ab9f-ab51ab946e34@wp.pl>
Date: Thu, 30 Apr 2026 15:56:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] drm/panel/panel-edp: Add CSOT MPP36 T9 eDP panel
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20260429145251.8445-1-adamszyma@wp.pl>
 <bc921525-1577-424c-a4f7-a0436f8a0ca1@linaro.org>
Content-Language: pl
From: Adam Szyma <adamszyma@wp.pl>
In-Reply-To: <bc921525-1577-424c-a4f7-a0436f8a0ca1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 9a8313837275705351fbb72a85a6111a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MfOs]                               
X-Mailman-Approved-At: Thu, 30 Apr 2026 17:06:40 +0000
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

From: Adam Szyma <adamszyma@wp.pl>
To: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda 
<andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent 
Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman 
<jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2] drm/panel/panel-edp: Add CSOT MPP36 T9 eDP panel
In-Reply-To: <bc921525-1577-424c-a4f7-a0436f8a0ca1@linaro.org>
References: <20260429145251.8445-1-adamszyma@wp.pl> 
<bc921525-1577-424c-a4f7-a0436f8a0ca1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain


Add support for the CSOT MPP36 T9 eDP panel (manufacturer ID: CSW,
product ID: 0x143d) used in the Dell Inspiron 14 Plus 5441 laptop.

Without this entry the kernel logs:
   panel-simple-dp-aux: Unknown panel CSW 0x143d, using conservative timings

and brightness control is non-functional on affected devices.

Signed-off-by: Adam Szyma <adamszyma@wp.pl>
---
  drivers/gpu/drm/panel/panel-edp.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c 
b/drivers/gpu/drm/panel/panel-edp.c
index f3cdaea89..0d0072f29 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2073,6 +2073,7 @@ static const struct edp_panel_entry edp_panels[] = {
      EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, 
"MNB601LS1-3"),
      EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, 
"MNB601LS1-4"),
      EDP_PANEL_ENTRY('C', 'S', 'W', 0x110a, &delay_200_500_e50, 
"PNB601LS1-2"),
+    EDP_PANEL_ENTRY('C', 'S', 'W', 0x143d, &delay_200_500_e50, "MPP36 
CSOT T9"),
      EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, 
"MNE007QS3-6"),
      EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, 
"MNE007QS3-7"),
      EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, 
"MNE001BS1-4"),
-- 
2.53.0


W dniu 30.04.2026 o 11:45, Neil Armstrong pisze:
> On 4/29/26 16:52, Adam Szyma wrote:
>> Add support for the CSOT MPP36 T9 eDP panel (manufacturer ID: CSW,
>> product ID: 0x143d) used in the Dell Inspiron 14 Plus 5441 laptop.
>>
>> Without this entry the kernel logs:
>>    panel-simple-dp-aux: Unknown panel CSW 0x143d, using conservative 
>> timings
>>
>> and brightness control is non-functional on affected devices.
>>
>> Tested-by: Adam Szyma <adamszyma@wp.pl>
>
> I think it's assumed you tested the patch, so drop this.
>
> Neil
>
>> Signed-off-by: Adam Szyma <adamszyma@wp.pl>
>> ---
>>   drivers/gpu/drm/panel/panel-edp.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-edp.c 
>> b/drivers/gpu/drm/panel/panel-edp.c
>> index f3cdaea89..0d0072f29 100644
>> --- a/drivers/gpu/drm/panel/panel-edp.c
>> +++ b/drivers/gpu/drm/panel/panel-edp.c
>> @@ -2073,6 +2073,7 @@ static const struct edp_panel_entry 
>> edp_panels[] = {
>>       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, 
>> "MNB601LS1-3"),
>>       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, 
>> "MNB601LS1-4"),
>>       EDP_PANEL_ENTRY('C', 'S', 'W', 0x110a, &delay_200_500_e50, 
>> "PNB601LS1-2"),
>> +    EDP_PANEL_ENTRY('C', 'S', 'W', 0x143d, &delay_200_500_e50, 
>> "MPP36 CSOT T9"),
>>       EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, 
>> "MNE007QS3-6"),
>>       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, 
>> "MNE007QS3-7"),
>>       EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, 
>> "MNE001BS1-4"),
>
