Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A417CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6FB10EC2F;
	Tue, 16 Jun 2026 15:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xerLUgv9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972D910EC2F
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 15:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTpoRGoy+cJD4S/zMI+2elrf9Aks98u7sM7ZQ2lCLibvuikxpZKGJ6BgwShZ7crN3ZD+OnKFTGT9YTbn/A3HYQTScbhTKUVeHLedZ6Xnv3Du/dNLoGsuN/08UP2XvhsHFmeTt+c38ffx9Tlzs8/hmccDrFxqLWRG407W9+W4ksIsWtse3sy9KbB8cA8mxI5KhuP5T6ob1THKvqXsNXLzNwLpB1OdKMRHXMP1cUGE8wS8Cui6dhm6Kp4V3U9GryVvkntU17wZS0/jCuB0NH9fRdOmUvj8eQLlaUal16CRSIDtQoQIf8ggHc+jaR80YDr7vIyCBnw58XgdruhnhHg3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfO/dInM6yttWsyz3txZtJASIVYsEszz7SW7Cw/64Vk=;
 b=VxjkMSbHkC7FkR1lSdIpXYjyjQkSx61b0eD2jbOXzexmlkI4zCV9q059cYBsP1rCbnBTM7hteOmGtxVrN3V8Isqj5D1VZb7vXRy+T0yw0XmUsU9XtxVHFyxFbVw7wDmozVQhbeFtSanWphpdwKuNOqGBsdZu8YvGZAnjkBZ1/b3mMrPcV1mAsvgEmS3LjRV/XEY6zmEmLdVZeZPQwaBfpjwgYgftc5SpUKVGkuDdRJ79xFKrjld8EkwjFYlR3FLiXJvrgZxSKr132JXTtgwlfWx0BVHY9QYUr642Pjg16xQkBAZDEk4z/JHn/Ruml0PT+WP9VD+UByT4G3Bsi5uIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfO/dInM6yttWsyz3txZtJASIVYsEszz7SW7Cw/64Vk=;
 b=xerLUgv9xsFt9mQyL/Y+WROhRFXT1Ha4YRAH1uk8Roc7jayP8ap7xCE9GFlK49GP2k0h8JXRSSmTl0spFLds0Ige8cN1Z5M6vgCRRvRQ3WOlQ1efWPwQbthZM94CLXgAyNohfo2lh2u0rZVb3LOtxTWWpO8Cn8dKbcHDUKTfvTc=
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:09:11 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::8b) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 15:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 15:09:10 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 10:08:50 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 10:08:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 16 Jun 2026 10:08:50 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65GF8kVs258336;
 Tue, 16 Jun 2026 10:08:47 -0500
Message-ID: <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
Date: Tue, 16 Jun 2026 20:38:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: LiangCheng Wang <zaq14760@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Wig
 Cheng <onlywig@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260616083921.4066690-1-zaq14760@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b8394f-0f55-453a-0147-08decbb93882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|22082099003|18002099003|921020|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: YkKiyS+RMGKuSvvwgSOrB1c3JVIHx0np9gIZ3x9oewEkDjkCDflcOCmdVdjOrmlWEADKEBC9YkhNZaqmu0/R4lcL4EW8UtSYlJgDfWunmuJpDLIQo0VLa3VxbFuiYuWfWrgh+lp4CWlmubpnGYx3cbvJb6Wm6v1tANkeRc/7YsJTyKI1Kh529OrKHD461LnU2VMggwvKVGrjgXfGUG/U9SYSLSOL6YQmaje0sew4REebhXbS3ShekYdWQX7mOZFgDEKgLw4u6WbpnkdS0SGjSGBkWbfbKaQOdKhBRpOWK96eXQ3I3ATzH1sWGIZUeV8zbNtcCHSi17L6YveyOC9I4wu41SAl34smizdCMbbb4oq0+2Lsf2vWzf6ekjBSOo2ofAH9ZvgsHb78WhRq0DbYraNwYsveVGecstWcUB/7niHlo0ThPsz8dBsAmgf6zRRbe7SXhHNt1tzZRwCp6JDid4G16wBtrJihf22rpW47VCP1M+j+t+EVuJjPMq9JAZBAJb/46Zm9K4rN1jjKFEO/SuhhP5pdVQIQz2d7r14wId9rxElw3LM4SP4bvvd8A4OuDe5AIS2ROrdGUUYSET1+BxdCpjtBePoakZDhc8+8YM9ZUbYhzP7jXRoEiAFdriqEfKAYMFEgWvMiuKd1FFrfpgnML0Qoo1pa/7rR0Fmb7yt4uBoc0GfWaSmZQBePXJ2nZBtaGKOmAohDnWxOFYp3s7NENwNCObBQsK42qfVmsv2oMnZaGKU/k+1xtfKvVSfjuDYwo6hnh00q3g21OAXDlw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(921020)(4143699003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z3xbVCn/aGqu/16RqZN+VEoE6DLJe2x0lq2JNacTaAJ7uhmGV2GwWXwY2G/xpuphmoXf4fmmfXt3RWwEfeZFKBz6097UE+ILESUuJflL51Y83dH7NtDyDZSv4gO8izhhsx7hxzGdjgwT3snammfRYMKweZZeIgIuAvPbeQHiB2o3Z3A2k5Dw+Xm6viOC3fqG2tRLtHU+N8iw2wIHRJj6HMvuVlb0wQcn8hHUyVYNVzTbEcJ8lyYbKD30Hi8IXwQVyd6p/U2V2q5K10bFe36V4XBpP5uZI5F+Tn/uafPLrVepR7coX7cDD6ftf8r0cFqTOYdMs9/bO5T+bQ4uhD8fR+aQYlqgti3OB6E8lFQ2x+FIhsDc+E99aWjq8K/oqgeX/+nwlzBuM0+Davg+ZsoZ+PQCfKq9JKF8wTTEZLMkbm0W0rA/6XBHxyX4ujpZo4Wh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:09:10.9382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b8394f-0f55-453a-0147-08decbb93882
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
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

Hi LiangCheng,

On 16/06/26 14:09, LiangCheng Wang wrote:
> Hi Devarsh,
> 
> Thanks for the detailed review.
> 
>> 1) Could you please share the datasheet for the display controller used
>> inside this pixpaper version ?
> 
> Unfortunately I'm not able to share the controller datasheet publicly; it
> was provided to us under NDA.
> 
>> 2) Does 0xFF or 0xF7 mode work as well for your display or is it strictly
>> 0xF4 which seems to mean that analog and osc bits are disabled ?
> 
> I'll test whether the standard 0xF7/0xFF sequences also work on this panel
> and follow up with the result.
> 
>> 3) Also could you confirm which display controller IC does the PIXPAPER
>> 4.26 use ?
> 
> The PIXPAPER 4.26 uses the Solomon SSD1677, so you're right that it is an
> SSD16xx-family controller -- the commands it uses (0x01, 0x0C, 0x18, 0x20,
> 0x22, 0x24, 0x3C, 0x44/0x45, 0x4E/0x4F) match the standard SSD16xx set.
> 
>> it would be appropriate to add this panel as a new display panel entry in
>> panel-ssd16xx.c rather than a separate driver to avoid code duplication.
> 
> I agree that consolidating SSD16xx panels under panel-ssd16xx.c is the right
> long-term direction, and I'd be glad to converge there.
> 
> I'm not yet sure how SSD1677 would fit with the controllers your series
> currently targets (SSD1673/SSD1680/SSD1681/SSD1683) 

Thanks for sharing this information, yes it makes sense now that it is 
using ssd1677.I have the SSD1677 datasheet and I think there should be 
minimal change in the driver to support this controller, I will be 
adding that in v2.

-- ours is a larger
> 4.26" 800x480 panel, so I suspect it may need a new controller variant.
> Would you expect panel-ssd16xx.c to be able to support SSD1677?
> 

Yes, I will be adding SSD1677 controller support in V2 of my series, 
hopefully that should help and after that it's just a matter of adding 
panel entry for your pixpaper panel. I can share you my branch with 
ssd1677 support once I have it ready.

Also, I don't have PIXPAPER 4.26 panel but if you want I can share you 
my branch having ssd1677 support and additionally I can quickly add 
boilerplate pixpaper 4.26 panel entries on top of my V2 series referring 
from your patch so that it switches to using standard ssd16xx commands 
and ssd1677 quirks wherever necessary and you can then validate and modify.

> In the meantime, would it be reasonable to take this smaller standalone
> driver, and migrate the panel into panel-ssd16xx.c once that driver lands
> with SSD1677 support? I'd be happy to help with the migration, and of course
> I'll defer to your and the maintainers' preference here.
> 

I think it makes more sense to use already posted unified ssd16xx driver 
which already supports standard controller flow for the ssd16xx family 
with additional controller/panel specific quirks and has interface to 
support different panels thus avoiding massive code duplication and 
leveraging already developed functionalities.

Regards
Devarsh

> Regards,
> LiangCheng

