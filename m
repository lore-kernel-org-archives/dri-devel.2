Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A9DF506C2
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B561610E0C6;
	Mon, 16 Mar 2026 12:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o5v/0nRN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F0F10E0C6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 12:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vihO+TgcNgm/XmvOaUt0D1CqoCrvn2koN9aDpOWzg2iwsqcxeE2GbpQXPdGBrXwrbyL6DHqsO7q0C36bllkrwDi7JZcWJ+95OkxWu3Qr+zZ2+DWG4NrNwXy1Bv+RvfP38Dt9/uLJ62mBEk9d8HI7w2Xg4EZBFWW7klElUtENu64IfvWAaeQWY9hC+ss8BHIn893I2EctVikcKKwcYAIaIFHuZk6jrl41o7nRlyeWHRHP6Mz7rxF3hvfR0XmQevRa1iOf2DHRXQ25NGDXRj03nTHFnlWzRnnlUtESknXKZZ6Kat8H2DMMheXRpemBeKQgu7mzyOW1BMMH8T3Zl7XUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D34ECehwJ8S1XScVw+Cp4IBEAgaW0DOf5yhV4IA5TTA=;
 b=Hn+T/RkWwqmUI3Y7s9ezW+wNRVmDZhOFjviBG+sJUjMipB7M1wrgMHgPf+/Pa7rgw1NvunRr0r/op2fq/4zxMtvISAmc8q0Nby5oHw8o9ZJBprbq9ZbBkMbSdhqdp91jJMc8AdU039sYZHwJiXANvgGQbiLBzXD/Lecb9ft6QuEf/zaL/Ful/PdQvKg4DLg3YRg/PVBZ+tqZgWRdDxqptF0PwvSI7YNlL/5imnPljN40Ryuqo67lhAiay6wbjzgD9ZKtYDF4w9BxaJ378T1l3Zblh1D79EBfhT07fblhyfDh/JTu3a3PoXl+WqvfNwb30M3oPwPwO8BBWmL2s4yCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D34ECehwJ8S1XScVw+Cp4IBEAgaW0DOf5yhV4IA5TTA=;
 b=o5v/0nRNHQ5hAaAFnZyJRaEpI+joBH9SdCzvUz//pbO3++x3yQZrZTZogyNzgEfUs0PRivffidk2wBxFhp1WO33FGTio+XSPT8oGFwxhhz4hmbcejcYs5B2oO5JABFCfjeCNcMCkXOxD5gmrVDkmguMZuHORFexTC1UP+VSahrk=
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Mon, 16 Mar
 2026 12:37:01 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::92) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 12:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 12:37:00 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 07:36:49 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 07:36:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 07:36:48 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62GCah1g1295891;
 Mon, 16 Mar 2026 07:36:44 -0500
Message-ID: <7b3660cf-cc5a-47d6-9cc8-362544cfdb37@ti.com>
Date: Mon, 16 Mar 2026 18:06:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: display: ti, am65x-dss: Fix AM62L DSS reg
 and clock constraints
From: Swamil Jain <s-jain1@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <devarsht@ti.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <praneeth@ti.com>, <vigneshr@ti.com>
References: <20260129150601.185882-1-s-jain1@ti.com>
 <20260205-spectral-dramatic-jellyfish-cec4e2@quoll>
 <4b554339-95e1-4980-8899-57ba637ba80c@ti.com>
Content-Language: en-US
In-Reply-To: <4b554339-95e1-4980-8899-57ba637ba80c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|SJ0PR10MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: aee34800-1d20-4377-c031-08de8358b842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xPqh7jTgLsynYN/9NepoYV7dbHl0oCzVV0NSZ6FxQf3A/weWpYwUlsnO52D4Gy3aMHOesgaJrReF6Fw3z2ikxt+eSrl774R7/b7Vm+DAonKyMbK7Kh8lKoQZSn5bxRlqyKzN3ecBxxwrq5dh1DgsvVzqoJ78awNz5lWeKiKnYMwQTBvsV0i2AkAzjrgkz1E6O8I+6V8lnneMzBm/1I7Z/6TK3gta+kejLHyPYLyhG+QGSguOqR/FARxxXIgqLrSpmnaS0el6DXrR3vs9pBFmGqNdlNdFenEblrR3S3OYo7ELzHi6cAuC22rR4mkL0/a2ysyrji4ExVhOx0KzM0SHHI2yfK1G+mNHExWF7Uasq+M6lHR8UJG5W4RfHs7X4pTrUc8aM2+yYmjhNufT5coU4VKrTEv8HTvs7VtGXCtV230/zE4kJVE+XT6a9b0KXLWM1W2PK4dfJj1YqOwCAeUKITZfRsNzaMbC4MJQGBwcKw/6JfLYMI4nbKn2Q/iXjezY6C7gDWq9384vBy3W8G4YJaGhJS7ECdlRS4zWi8VA9kyDBbY32C1NeL44S0BQ8Vd6WdbTErADiutwzbumNKwpnE305eTflR029BZpJ46xVxCmJZUtGwfe7eH54UVwNAzUzKGIrURfbojr0IkIH907f9H5aYfJ8UlMeHfFR2WaQKQMmLN4s0nQLCSmgg72iCEsi6lCPH2YPL6yn1rk9okJan9I/iMhDePNnN5gz6AQvi8x95nuA8qIlFzjAJcqQ6gGjeNgEIer42PkiuNGV7m/N8ngRn6RTkAZSoCvd3XMk/M=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FBs2NYfL5GF9CQrSzwsI9/StG4GP6E6ygWOrTp9XvonjU9g8W+Xw6PrK5dLRPzBFVoy0s+sng2hrM6gz+PNpl3VqGpBUvLbEI/8y61H4cE/i1VANQhhpkQ5+Wn39LBCIpYmlNDj8IRVS3KDyWpCf4cSwCGnQSV4pEJP2dCdsNetPLAGNwRLUDMEH057/jUv6l2bClw3EElZ5Oz3jpGwrjl+yO5N/eCY7kHo0h4YRPh7IY9SKGA2HTSAzIyUDpfwgA30NpOmzcaXWMooC5IhYwSAMeKiaAthAztbcw9AunWNJzWOshA6HjOzMSl4qr7piaHkBR0L9/8tQKpTykXdFd7UKkxGGQ7SIFGUwXEP2ekejq8dNLxl/Qs0fjI9arMO855dw95oJCVWk+gNDBLkWi9R/oqJ9lFgkzsQBx015ISqMy3szxUQtKL5gxo3AzsUT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 12:37:00.4013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee34800-1d20-4377-c031-08de8358b842
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
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



On 2/6/26 19:48, Swamil Jain wrote:
> Hi Krzysztof,
> 
> On 2/5/26 18:55, Krzysztof Kozlowski wrote:
>> On Thu, Jan 29, 2026 at 08:36:01PM +0530, Swamil Jain wrote:
>>> The AM62L DSS [1] support incorrectly used the same register and
>>> clock constraints as AM65x, but AM62L has a single video port.
>>>
>>> Fix this by adding conditional constraints that properly define the
>>> register regions and clocks for AM62L DSS (single video port) versus
>>> other AM65x variants (dual video port).
>>>
>>> [1]: Section 12.7 (Display Subsystem and Peripherals)
>>> Link : https://www.ti.com/lit/pdf/sprujb4
>>>
>>> Fixes: cb8d4323302c ("dt-bindings: display: ti,am65x-dss: Add support 
>>> for AM62L DSS")
>>> Cc: stable@vger.kernel.org
>>>
>>
>> There are never blank lines between tags.
>>
> 
> Sorry, will fix this.
> 
>>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>>> ---
>>> Changelog:
>>> v1->v2:
>>> - Remove oneOf from top level constraints, it makes bindings redundant
>>> - Remove minItems from top level constraints
>>> - "dma-coherent" property shouldn't be changed in v1 itself
>>> - Add description for reg-names, clock and clock-names
>>> - Add constraints specific to AM62L and for other SoCs within allOf
>>>    check
>>>
>>> Link to v1:
>>> https://lore.kernel.org/all/20251224133150.2266524-1-s-jain1@ti.com/
>>> ---
>>>   .../bindings/display/ti/ti,am65x-dss.yaml     | 93 +++++++++++++------
>>>   1 file changed, 67 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x- 
>>> dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x- 
>>> dss.yaml
>>> index 38fcee91211e..dbc9d754cf9e 100644
>>> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>>> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>>> @@ -36,38 +36,18 @@ properties:
>>>     reg:
>>>       description:
>>>         Addresses to each DSS memory region described in the SoC's TRM.
>>> -    items:
>>> -      - description: common DSS register area
>>> -      - description: VIDL1 light video plane
>>> -      - description: VID video plane
>>> -      - description: OVR1 overlay manager for vp1
>>> -      - description: OVR2 overlay manager for vp2
>>> -      - description: VP1 video port 1
>>> -      - description: VP2 video port 2
>>> -      - description: common1 DSS register area
>>
>> No, I do not understand this change. We spoke so many times, documented
>> it, wrotre on presentation slides: broadest constraints are always
>> defined in top level. TI received this feedback more than once.
>>
> 
> There is no superset constraints since am62l register sequence (common, 
> vidl1, ovr1, vp1, common1) is different than non-am62l SoCs (common, 
> vidl1, vid, ...-> here it is different), so thought to adopt this 
> approach where there is if-else block for each SoC and ran this through 
> dt-bindings check as well, looking at the replies maybe I misunderstood 
> what the suggestion was, reading the reply as I understand below is the 
> suggestion:
> 
> ```
> reg:
>      description:
>        Addresses to each DSS memory region described in the SoC's TRM.
>      oneOf:
>        - items:
>            - description: common DSS register area
>            - description: VIDL1 light video plane
>            - description: VID video plane
>            - description: OVR1 overlay manager for vp1
>            - description: OVR2 overlay manager for vp2
>            - description: VP1 video port 1
>            - description: VP2 video port 2
>            - description: common1 DSS register area
>        - items:
>            - description: common DSS register area
>            - description: VIDL1 light video plane
>            - description: OVR1 overlay manager for vp1
>            - description: VP1 video port 1
>            - description: common1 DSS register area
> 
> .....(Similarly for reg-names, clocks, clock-names,...)
> 
> allOf:
>    - if:
>        properties:
>          compatible:
>            contains:
>              const: ti,am62l-dss
>      then:
>        properties:
>          clock-names:
>            maxItems: 2
>          clocks:
>            maxItems: 2
>          reg:
>            maxItems: 5
>      else:
>        properties:
>          clock-names:
>            minItems: 3
>          clocks:
>            minItems: 3
>          reg:
>            minItems: 8
> 
> ```
> 
> Could you please confirm on this?

Hi Krzysztof,

Gentle ping, could you please confirm on the above design?

Regards,
Swamil.

> 
> Regards,
> Swamil.
> 
> 
>> Sorry guys, but you are not individual contributors which do it in spare
>> time. Why the same feedback - already documented - has to be repeated?
>>
>> Best regards,
>> Krzysztof
>>
>>
> 
> 

