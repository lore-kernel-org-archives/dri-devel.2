Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB77C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6D710FB9D;
	Fri, 25 Sep 2026 16:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJbKFnDM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306A410FB7F;
 Fri, 25 Sep 2026 16:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/Gy2C6QiIuIM9EKS9A6P0TWUfmX9SfRurt2jEPJfJ4/6SXi4WdGDW+TJwGPH2PUd90PkkKzj9RcK8YlcSrD0RoG5M5vv1OL7khrMKWpeZ6iD/DkTiyGPN2jTYRq2ToZSrWMxqiDRICUpFbiAacscUTeqnXoxvVXzQmpTvSlvkM4PnBYAohaMmLSbuYlLWoRWgOXZ/nEgYmBnkz7ZE4/ZoIx5UKemLC+OP0VO0krvXCf3yAEBdTehDZVLI0V7R3DAvdEENVxwUsOZDyQ6emevVmqhRW8h6gvmHDj/QUTCw3hDl0J4+aO4+eXF7tz17P6g0qVR4gm047fD5I8TvoLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJFvTFKpM6uPKDULl4M1nT/7vdmgh1gHiXkBsPr6S5E=;
 b=O4ZY73KdXcLDxwB+oVDPJzll3kt6/64oZumiGxXto3anIlNai4a1r0ufAz8WFxuM64SlW7ElVX5KP+T5MV4HRmzQQmaaMSL7n5uQCKseTyG0j41Xh8pQIB4zpXhb044uOpH9m5LjlokE3lDbnfmvE17Icj3fJNdfzMMamX+t5hvH1WMXr1Ir64GgFE5Oeok5UbvADxROXRzhzWa6zmT0VY3DW6i31Rv5qVBTz8iP+INt8SbswTnzW7MjD8O9pAH1UDEJ86bHlhp4RKIlCHbPjMI/6bFdkYiU1qSYcZH8HtKb+vG3RQtq3CiefVnZuZnYKYal9994+5kxx2ds9tMe3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJFvTFKpM6uPKDULl4M1nT/7vdmgh1gHiXkBsPr6S5E=;
 b=eJbKFnDMiJfMc2OGdzzR7dQEJscc493qUP7ONidQ3tdyciSzReZ1Lga57TcTJGNVdPJhFVuAVXGTTYSNNaY0PfapySY8ANzVO+a/GX/LZg8KVjqZ+NQZdaBVLGSildxQRmUzhFClmRwNXRPrmJ3zWYszhB7O0bh4jBDCBuwrzis=
Received: from CH2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:610:53::16)
 by FT1PR12MB222952.namprd12.prod.outlook.com (2603:10b6:170:d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:30:59 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::6e) by CH2PR17CA0006.outlook.office365.com
 (2603:10b6:610:53::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 16:30:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 25 Sep 2026 16:30:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 11:30:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 11:30:56 -0500
Received: from [10.254.92.96] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 11:30:55 -0500
Message-ID: <8a650274-008a-4515-95a6-9cd200eb12f4@amd.com>
Date: Fri, 25 Sep 2026 12:30:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/14] drm/property: add a per-connector luminance flag
To: Thomas Zimmermann <tzimmermann@suse.de>, Mario Limonciello
 <mario.limonciello@amd.com>, <dri-devel@lists.freedesktop.org>,
 <harry.wentland@amd.com>, Simona Vetter <simona@ffwll.ch>, Alex Deucher
 <alexander.deucher@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <superm1@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-4-mario.limonciello@amd.com>
 <b436e947-198d-40f6-a14e-de26cceb56f4@suse.de>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <b436e947-198d-40f6-a14e-de26cceb56f4@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|FT1PR12MB222952:EE_
X-MS-Office365-Filtering-Correlation-Id: abda830e-0bb6-4e2b-949d-08df1b226196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|42112799006|23010399003|376014|7416014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GqJWWAC5DoL4dGxJ74qQ2Xkmx9FQIPzuUGeCjD6wurTQxyW0UbVIGJYYYejya2jlp10eFcOjUZV9nPKxV+EE0aE6C7eL7IVeYeDjMprdM+RjILIR9BKR+vO2Orq372Yf+hWMFmbBNoRw7SBw7/b0xap4cSDNhpdkPHf9yeFPP/c7SMkc8XKkVngNOgqV3qUBit5ZK6ylwB11Vrt86yeCV9oMWrla1TFJFLqk215pEY8NYZgOmb3FZXqg7ta0n9xzsgGCLSX1F6aq1gBW/L5T5yoF7m7ecePhwl9TNTcdTy/6MnPNELYgqRAIW/Ejd74fsdregngJoNl2Lo3KEIONCU0sgj++X6lsgzjtJrJMJDAsUjNXXc+I29lWbDpKlCFFkcw4Upqk7zZi62/VpYZZ1zNuixpZwqGYsfm7XRF0ZfFzqGX9Moh57ppBtr1VguKF1BiPmffKCxaXhtN+b2gKvL1Gutp2RhAMB+cyysiPUuBD/Aui0s1g5Bjq4/RmHOZcRjYARZ/Qt/t4m61k0OErcSE11N1GMSeysuRo0agXIJHH2D0nmdkYQrv5LqxewAMSsJgFTPFudPT9yZoRk7G03lVBvF3gC94QSzGdy18epTffqAYF9bz/LsjuWsjoAdnq5U4hbRsvIBcWnmJh2omx8roNCJ6wg69hPebfnPiznQT4oHtxB4XWTgPHqUKM/wrbOcldJj1qqQ8Whsh+HMWO+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(42112799006)(23010399003)(376014)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zNEuhFA8LsT5XNYQ9eQdzNlnz3/zY7/3IvsG5W7QN9YW7iKv6bt9W1ueXlEILs7XKGJFoH/3xGeaClthut5Ps5EmeXO3vvghbv8MBnMY+c+pdhkpn/hsOuTEWrSaaDGzmuG6COLjdn7FvjbLE9mGnkSalCwEqmJu778nXx46dnHtTdDZyFrKZaUaOP2yFyIeyQGcxOOXWpVgRm88BqlmR8P7JYxNQMWOefOs1eueucj2Z3owLIO0v3UBdw1KDKempgajcoM9nwAQU81gJkpM1tZ1muWDCz8tM+BC+OScJpzgsQgW+LxsXlJiSWXT87zkjJaSZj6YjfiFYC3z9Z7CNrmdxsGNMim3Fif0pYVBHxN9ipahd+Wp7wKvvxjNJZUFIpdAZYchF53mm8ABG7Onq1czLOvMhj1GTJqk/C99Rd7s/K7Pq3rVRNQg9SJqjR0P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:30:58.9444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abda830e-0bb6-4e2b-949d-08df1b226196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB222952
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



On 2026-09-22 04:32, Thomas Zimmermann wrote:
> Hi
> 
> Am 08.09.26 um 06:40 schrieb Mario Limonciello:
>> The upcoming per-connector LUMINANCE range property needs to accept the
>> value 0 (to turn the display off on DPMS-off) even when its advertised
>> minimum is 1. The existing check special-cased a single device-wide
>> property object, which does not work once every connector owns its own
>> LUMINANCE property.
>>
>> Add a kernel-internal is_luminance flag on struct drm_property and key
>> the value-0 exception off it instead of a pointer comparison. The flag
>> is not exposed to userspace.
> 
> I don't think this is a good idea. Let userspace control display status and luminance independently.  To my understanding, both are independent devices. Just because the backlight is off doesn't mean that the display is off as well, (right ?)
> 
> Best regards
> Thomas

Yeah, backlight off and DPMS off are quite different. The CRTC is still active if backlight off, but that's not the case for DPMS.

I agree that we should detangle LUMINANCE from DPMS completely: Leave LUMINANCE alone when DPMS_OFF. If LUMINANCE is changed during DPMS_OFF, save the state in sw. Then on DPMS_ON, restore it to panel. Sysfs seems to have the same behavior today (I just tried it on my fw13 laptop).

It would be good to remove references to DPMS on the LUMINANCE property in patch 04/14 as well.

Thanks,
Leo

> 
>>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/gpu/drm/drm_property.c |  6 ++++++
>>   include/drm/drm_property.h     | 10 ++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
>> index f38f2c5437e68..adccee10cfde4 100644
>> --- a/drivers/gpu/drm/drm_property.c
>> +++ b/drivers/gpu/drm/drm_property.c
>> @@ -952,6 +952,12 @@ bool drm_property_change_valid_get(struct drm_property *property,
>>       *ref = NULL;
>>         if (drm_property_type_is(property, DRM_MODE_PROP_RANGE)) {
>> +        /*
>> +         * Special case for the luminance property: allow 0 to turn the
>> +         * display off even when the normal range starts at 1.
>> +         */
>> +        if (property->is_luminance && value == 0 && property->values[1] > 0)
>> +            return true;
>>           if (value < property->values[0] || value > property->values[1])
>>               return false;
>>           return true;
>> diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
>> index aa49b5a42bb56..8bb568a4cd485 100644
>> --- a/include/drm/drm_property.h
>> +++ b/include/drm/drm_property.h
>> @@ -188,6 +188,16 @@ struct drm_property {
>>        */
>>       struct drm_device *dev;
>>   +    /**
>> +     * @is_luminance:
>> +     *
>> +     * True for the per-connector LUMINANCE range property. Such a property
>> +     * additionally accepts the value 0 (to turn the display off) even when
>> +     * its minimum is 1. This is a kernel-internal flag and is not exposed
>> +     * to userspace.
>> +     */
>> +    bool is_luminance;
>> +
>>       /**
>>        * @enum_list:
>>        *
> 

