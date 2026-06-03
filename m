Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE91CD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8767E10F7D2;
	Wed,  3 Jun 2026 03:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tls3pMld";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C96010F7D2
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 03:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isLday1PpkhmGVcDtoKKEgnGjFYC9OZyNWoA0Knn9Hp4b+rIMozbZUhTnSpytDoEG6Bx3f87GC1aNrjZSeWoqZf4j3Y/o6xZw6Dl+zUwELPCBFsRyQXEU8EesdqtUthxAB/98z54iH3lvUUgdDM7YbBk39tCz1okHZ//pAf7vQW1a0HztexCyxW7iEnzJrWvBO8/C8tXXzZ/vDuAqsL9IG+ssQnOGP6F+djALxV9qouXEWj/zWyhUN3Ra/G4X0+3tG4tOpNnJcczL7/a+v4ov8Sc//E8RKS/uepHKdzWo+geBx0lBqxC1z4hCZ5UJHK48gX8VNtT9l3lEE8ZvFtUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5UcP/jjiW9zObnxxX22Aguo72Y81tK6Dhg3UENBE8o=;
 b=Y/Qnrocv7Q5cRZzLQ8YXslzBTPsDBlJQ9wiqW7LAodoIMNEEZYLhF+sEayVcWhJJsgSkB3hhmt6zn5dYcUcuwIR67Ia9mo1AkKwQLw1wcjUnVs746GcQ0gOICFUu7UB/1VOzycDjDJH9DdD8Nd3e5EjgmOzEk/H3OiV+UEtmEATy/YLHK1+GifVE8vug8YjQytXNc4Bz+pLn07oXgHB3NpfQzrz5ATemzdCxxyfj+0SqFDSSYjtzfJy1Df2w0veHmtY5xs1r87n+7prAR+aEoa5sP7y3R24aeh80+4MMenZPosX83Ms29M/oGnFCE8YDkvMK/XM7XOFv1WaXZuD/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5UcP/jjiW9zObnxxX22Aguo72Y81tK6Dhg3UENBE8o=;
 b=Tls3pMldZpMw6oZyRoV8JBcjnOiGZqBwg0mC/7W5N6VOt0TW1OpBoJoee/yUVQh7EvTDKlpfA7cOtBidoBshoNB16fdHCt75yUjqwk9jaQgCoLJHA0mR550DYdMBH5VmHuK2B6oKZUEnemHGCziu2ORjqeOu7rA2YQx7jgECIlM=
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by LV3PR10MB7940.namprd10.prod.outlook.com (2603:10b6:408:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 03:19:32 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::36) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 03:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 03:19:30 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 22:19:27 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 22:19:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 2 Jun 2026 22:19:27 -0500
Received: from [172.24.18.244] (ltpw0ewr2k.dhcp.ti.com [172.24.18.244])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6533JMdX333662;
 Tue, 2 Jun 2026 22:19:22 -0500
Message-ID: <8d58eb4c-e311-4327-bf52-a08c6f25865f@ti.com>
Date: Wed, 3 Jun 2026 08:49:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
To: Devarsh Thakkar <devarsht@ti.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <u-kumar1@ti.com>, <sjakhade@cadence.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <s-jain1@ti.com>, <y-d@ti.com>,
 <tomi.valkeinen@ideasonboard.com>
References: <20260205085233.81678-1-a-kumar2@ti.com>
 <b267202b-3971-43c0-927f-6320517161d6@ti.com>
Content-Language: en-US
From: "Kumar, Abhash" <a-kumar2@ti.com>
In-Reply-To: <b267202b-3971-43c0-927f-6320517161d6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|LV3PR10MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 82920755-09e5-4760-afbf-08dec11eed68
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|82310400026|1800799024|376014|921020|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3QnIrgT4FBsGkKggFRZKgR3uvUXEd+x6TXhqJdHPOpnXnR3xqvwhDJiueWYK+2rQEGaPYqs3MM33H1X+AVosMyXhK5YNSX3arssYgDUmvji4HriVDel12N+GeDJV1PLCpUTH9TvlYR/Ei1uYic/V6+QmOuxqhpxrJX55xuZcU/xEks3H9keX1aZSBU17zY3MP3ZM6Xuf83nurlTBUgXmrd7twXxQibizRsmRBjkLOVQRr5Pm9JW9tlPH0BwPIZqwoD57PJIh7NThnxUiLY2n4wv9jiko7NUbMLHDO6A9L2lfNYtT5z6Au7Sp1aE0j+n7Ek3L6emSQ6MTm27beQrCtNg4aP8KmD70kAL7tZ0jOhcXYxNHz1JmU/VayqAJuqbnZyfnmsLDMJT1spxJjWKg5PxAAvFa7lztjm6agQlNTUs1O4XVh/Tmo+DMJyVWp5pAyQTdATmPmlmY4LIBoBbNb9mYC/TO3urIaXiqrqGQQFd1xtHH90w7Qd8U5Ox1R5SZBiTL44yM3lAHYzIErvm5+N/LqMofleND8Oyv9a1Qq7FBC3Q7pkQiFl7jjV/IFWnukASX9r6NdA8jd44oAkSKjpgc7Foj2VvdtVUFPgchIRPkZIaDDVAT5XGhSXjCaibXWYAouywFRV2oL2ic1Id4SG19sOXNELX+m4v60wgHa/cn44gUqrEOtkXZgzlEsWxcHfYOO3wMJOj55DXlXShIXaYRRbdfx3U41yMIMz0gX/fWZZaFsMEXXt4LwWn+jxhBf7TUY5WrHLpeuMOfnOungQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(82310400026)(1800799024)(376014)(921020)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Pt4sL5vf4S/hwE+T4ficYiYpUZyejxhsUYW4k9b9F9cus5qNR65aMM8YsxZ+SGJtWJjpid9RlU8V+BRUizS2TeiAaoZsIAeIAYi8Gc/NLUoj4tcOUOkcBZZpBZTPCJuz2XmFpFPLilbHzePtq75rawXn1Da7Bs28a9B2fSEim0OKNJxifMZWiAJ6s0SuTYMctdUZpk7R+1VrgOUdDpL4oRKWANPHV+JkZAThwn+tPVfQCCgfcEJAzRl4/VrBKVFSFN9WTzLnKWsf1gZvvZEsz4r1KSxc5FJSIAw4Ldb7US0MI1gx7JgPFj73dgnBRpFR2rqNBNIXGxgy5P5G6JF7rJNEwZprG6NjR+8kXpCbzs78bCABfDoIZcFZvRtvQq7hLvV9t1MjkLEl1cCZ8zXnYDQxaG3QjL5lp2ou2Ma2BHK1cpUqR4n4ej1h/aVQDVo
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 03:19:30.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82920755-09e5-4760-afbf-08dec11eed68
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7940
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

Hi Devarsh,

Thanks for the review

Posted a v3 here: [PATCH v3] drm/bridge: cdns-mhdp8546: Add suspend 
resume support to the bridge driver - Abhash Kumar Jha 
<https://lore.kernel.org/all/20260601095041.3042950-1-a-kumar2@ti.com/>

>> +    } else {
>> +        ret = cdns_mhdp_set_firmware_active(mhdp, true);
>> +        if (ret) {
>> +            dev_err(mhdp->dev, "Failed to activate firmware 
>> (%pe)\n", ERR_PTR(ret));
>> +            goto phy_off;
>> +        }
>> +    }
>> +
>
> mhdp->powered_off = false ??

Good catch, updated in v3.

>
>> +    }
>> +    mhdp->hw_state = MHDP_HW_STOPPED;
>
> Above should be inside if block i..e if hw state was not ready.
Yes, updated this in v3
>
>> + spin_unlock(&mhdp->start_lock);
>> +
>> +    if (ret == 0) {
>> +        dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n", 
>> __func__);
>> +        ret = -ETIMEDOUT;
>> +        goto error;
>> +    } else {
>> +        ret = cdns_mhdp_set_firmware_active(mhdp, false);
>> +        if (ret) {
>> +            dev_err(mhdp->dev, "Failed to stop firmware (%pe)\n", 
>> ERR_PTR(ret));
>
> At this point don;t you need to
> phy_power_off/phy_exit/clk_disable_unprepare, and restore hw_state to 
> MHDP_HW_READY ?

I think we should only restore the hw_state to MHDP_HW_READY.

We should not do phy_power_off/phy_exit/clk_disable_unprepare in case of 
a failure in suspend

because the device is still active. So the driver can be used and a 
suspend can be triggered later.


>> +            goto error;
>> +        }
>> +    }
>> +
>> +    phy_power_off(mhdp->phy);
>> +    phy_exit(mhdp->phy);
>> +    clk_disable_unprepare(mhdp->clk);
>> +
>> +error:
>> +    return ret;
>> +}
>> +
>> +static int mhdp_pd_notifier_cb(struct notifier_block *nb,
>> +            unsigned long action, void *data)
>> +{
>> +    struct cdns_mhdp_device *mhdp = container_of(nb, struct 
>> cdns_mhdp_device, pd_nb);
>> +
>> +    if (action == GENPD_NOTIFY_OFF)
>> +        mhdp->powered_off = true;
>
> Should we reset powered_off flag for GENPD_NOTIFY_ON?

I have reset the mhdp->powered_off to false in the resume in the v3.

>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dev_pm_ops cdns_mhdp_pm_ops = {
>> +    SET_SYSTEM_SLEEP_PM_OPS(cdns_mhdp_suspend, cdns_mhdp_resume)
>> +};
>
> Have you considered using below ?
>   static DEFINE_SIMPLE_DEV_PM_OPS(cdns_mhdp_pm_ops,
>
>                                    cdns_mhdp_suspend, cdns_mhdp_resume);
Thanks for the tip, updated it in v3.
>> +
>>   static int cdns_mhdp_probe(struct platform_device *pdev)
>>   {
>>       struct device *dev = &pdev->dev;
>> @@ -2494,6 +2609,11 @@ static int cdns_mhdp_probe(struct 
>> platform_device *pdev)
>>           dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
>>           goto plat_fini;
>>       }
>>   +    mhdp->powered_off = false;
>> +    mhdp->pd_nb.notifier_call = mhdp_pd_notifier_cb;
>> +    ret = dev_pm_genpd_add_notifier(mhdp->dev, &mhdp->pd_nb);
>> +    if (ret) {
>> +        dev_err_probe(dev, ret, "failed to add power domain 
>> notifier\n");
>> +        dev_pm_genpd_remove_notifier(mhdp->dev);
>
> If add_notifier failed already why need to do above remove ?
Correct, we do not need this.
>
>> +        goto power_off;
>> +    }
>
> Also for non-gen-pd platforms this would pretty much restrict usage of 
> this driver, is that expected/desired behaviour ?

For non-gen-pd platforms, we mark the mhdp->powered_off = true at the 
end of suspend.

So if no gen-pd is available, assume that the platform has taken care of 
powering off the PD at the end of suspend

and hence always reload firmware on resume.

Additionally we only add this notifier for gen-pd platforms.


Thanks and Regards,

Abhash

