Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E07C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 20:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76EF210E0A7;
	Fri, 24 Jul 2026 20:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l25WwLV4";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7D610E0A7
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvl298/EUjF//swGwG7Lat6meDrMnDu0cvArWPG3Sdo/oYotmKMSZc5vdc4Ppm6fLxtHYry9IBdzdH7dRR9TFsfrSXEv5SQQGThJviEJEXc0ePFIiuKYYmIz7riUnP24iCqGRxPFntiMl6qjEm5E6rON0EmOuMlMfT0w4zHTqmH9hUXdE8sMWZCDEZghYXM/nOFuLThoye0UgBXPDeLcl43OOujKwgYlGyKT8vv5NSSRifMdGVCpa67sYBW1/tRX2gY/Bk9jzfAWAxo9xqv4Phajz8M2aEtBr3Q9N75eccviW6yGEY2bvMMWJ3d3wUEFxIewBdjowwFkWOoWPsu6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUf7do3+73ursZEhZ4FWo2wnE0Ui51NeO/LEPqzdm18=;
 b=WF777Fpx5Rw4+TWG5tVyHxqFSl/zyk/gUq/dsygPpfnBra6oXf6S2Sr3UeYziQjfcPZF/mb+8V2y6pvsCPmfd2VzYZXBA34xjJDTSe3uKqwEd18U4TE/0bmQJf6XDPp58U6xKfpLmUAt6JBuB2d/I/C00hTHIyEKva9ibCNynrJZsULk4g+EeVINOt1WQdAQQdRKeBJqiGlEaqCxIz/mE8EQi+Kgj80DgDZJrj6JIMMSOkiiHXBZr9ADIogcscqghPxRZMHAvx0QgVPMCaFFafAHbz6zWrzs2ThxhEKBTEHdV+GChjVXRz2sdX1jLhdRChabU5KiAJx4Lo5bK71++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUf7do3+73ursZEhZ4FWo2wnE0Ui51NeO/LEPqzdm18=;
 b=l25WwLV4k5QK32OGF13I8B79EJ0S9ibELH30WYW/tllmNI+ABshat2mmbjruPthWfH8o/Hc/MgwGtYOXO8azNWUrhWKJ9GKrXYyC3fXZt9IXBGL7y70xL4tABG0ofty731qqtZCPtTpWfX06dgzA28F9ciQ9/s0idzKuJalyWT+aCTzaBvEW41q0YRZdlDC+h3ZMxnd/kczUBiCD2VbMf/VuUK2UniTHeS+pwjofcF9xdUm8o030dmPpk0S02zJAoB2DEPnej0rR1MqPsH+REA76OZinZnGGm5FjfM6F6xTaqdUchQFsOFeYVxn7SeGPtPNZf1+PPMkcTkU2/pRqsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 20:45:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 20:45:29 +0000
From: Frank.Li@oss.nxp.com
To: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 vladimir.oltean@nxp.com, ioana.ciornei@nxp.com
Subject: Re: [PATCH 0/2] ARM: dts: ls1021a-iot: clean up dts related display
Date: Fri, 24 Jul 2026 16:45:21 -0400
Message-ID: <178492584046.3822600.14628851959169738931.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708-ls-dts-display-v1-0-1986b2611895@nxp.com>
References: <20260708-ls-dts-display-v1-0-1986b2611895@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:806:24::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 06737b89-0e3b-42c7-7818-08dee9c47f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|7416014|23010399003|376014|18002099003|22082099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 7SJmKpj59F1v59OPNwqJZPBJJv+1gnF8hxSEb1EnsmY5Vf3URigq2AotaX6Vji2dv6E/nF9J7bhBbj0f7lGM8qGjWTbUDH/ESNCXpsIYQOhrPaTWuxQBkhR27pQkPiM3MMsMnJRfxWAB9gU0mNjdAwZ0aQJBIJiKPOKZS4zh9yzqfkLG6t20BqRikigE+mYEIv9SGu+tPJ0lYapFfBFqpoAtNtW6sJjbDZffDtf7TdhbgPj2TpSmxvc9JYqotbI/BYXGC5JNm78rCIGaiIh2DCmiQ3gxsKkGmcBHeoNeHUrval2W4JNVI2dl5xUlJ4XB+t/4CUuKzeANF/WnAN6BPUNKpTm7sZ8j7nLqFsVCiVNab+JoaSX3/mkYz6x6zyRr11mozKFGsvvzpA813YaODJd7JGRQY6w+yNh/dNbpr4XdQpwTe8+mJ/3obizlX70x4jPgfRr80Y4mcIQjIhnoZ3AtelVxwDWtpr8QcGDWQRKzfRIpMr1vDu8ha1Fu7owQvRsuLl3BSeNy6Gy8cQLM8YUlFNuJ7GVAbkUtg7j09F4BRCIpV5PT4vt37fnx675k5Y4qOfMl28HN6j/bdOHm8RLKaiqCSnoVdj+dJYQHSwKpQa07YkmIs0AUmDu+Z81ngZxR+igprBj5ibzWpjUw0IYNrwMOK7N4tSQRqF6G/YiQ277scvTRmSqQX+PnwLM1bcV3ezuc8M0gYoLPeorqAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXFkN0dHWDh3NEl1cXpBVmVMTDJTbWF6bmZ5djM2cUxreStSWjM3VlZ6UmVN?=
 =?utf-8?B?VVY5VnVSOGo1Q1ZyY0lIS0pkOGRvdldIK3RmK1V5bEowT0lIZWcrNVk3bjJF?=
 =?utf-8?B?UEtMOEVzL3J6dTM0Z0ovYW5ZYTZKbWNNbm9XMUdXN1RRRmhIa0VJeFVHNHJP?=
 =?utf-8?B?YmJ4cC82UXo2dUxRVHJyOVZJaXV5Rk5qN2xOV2FvQ3RxMkdCK2ZLREVIaWc0?=
 =?utf-8?B?WGJ1bGgvTTMrQXdBY080c082QUQ5cERSUGlYZlNod1Z5Um8xeUZmY2o0Z2Zx?=
 =?utf-8?B?QUVIakdLVGZ0MnNBZzdCRXhUaWt2Vno2ZXY2UEozQkVtVDRZY1lpVGZ5TnBU?=
 =?utf-8?B?b2VyUEdWS2ZlOGYra2Zzc3plOTc4WU1FbXVZV1VHd0hjNlpMZWdIRTM3YVFE?=
 =?utf-8?B?Y0p5bUhQMGJqUHdSRUFvUlNrR0lIU2ZjVkxYRlhJL1NCRERIbEQ5ZFRWaUNB?=
 =?utf-8?B?eXNXMFY2TlhERGNTOGVUK2gvSmlDbktRUW5wSVhrMkQzSWpKWG1XOENnYWlC?=
 =?utf-8?B?LzJWTzJGaW1kcURULzZ0amsvUmpSN043R0tRRUxkcUJBa1pDN09ueUw4WVcr?=
 =?utf-8?B?ZTA0UU15WFdyUFZ5Zi94UnJKZmJvMEh6QXprZnF1VGNsUG1WdmJxM0JkVXdx?=
 =?utf-8?B?blBJSnRTSHhOZmtia0ZHdmdudS96Z0pRd0NKZHBDTE1XckJuRitWaTZXSWR3?=
 =?utf-8?B?Mi9ZN0dpZTZQNGxWbU9lNVgrMkhBMGZBZzUwTEFsTWxZck8xZzg1cjB2cXhH?=
 =?utf-8?B?NHJsbXU4UEVTeE0vUGtVWVREVDJHakJ3bkpMS2MrclJvUm1SWXZhbEk3a2x3?=
 =?utf-8?B?QnJNYmZTdUU2NWhNV2pEZ1cxSUt2WGF6UGJ0ZGJXWEpXa0tnTEdQSnFrU3Ru?=
 =?utf-8?B?STN3U1lEdklWbHdSeVpJTFpsWXpWaVZLcUZoVzN0K2hPQ2diM1BLWVdhRU0z?=
 =?utf-8?B?TjNZL0V5VUR6Nm8ydkVqT3dzc1VHVTB1eWt4eUdWd2xpTi9PcGJSZXBCT3lB?=
 =?utf-8?B?amMyYVorcE93NFM3dUVhYWNyWENPQXdFbXh1RW9peVEzclUwQWlBREc2dVRv?=
 =?utf-8?B?UndiaExaRmwvOXcvSHhybjJTQlB1OFIyZ1pWT1pJU0lEVnFnNlpaZWZnMkIv?=
 =?utf-8?B?d3p3b3RRdDJtZlMzdmZndmo1eGtPbEkxNFdTOTZYcHhRN2M2dGlTN3VKOEIx?=
 =?utf-8?B?R0R1TERkRy82NzBBQ2Nyb3VpdnpnRlFFV2FML0pMQTc5bUk5TVptT3FvdnBY?=
 =?utf-8?B?dHh1bUFzdS9sbmw0OTVFb1NHVW50enVhbmtNZzU3MGYzNkZ0amFQaG9MSmwz?=
 =?utf-8?B?WlBhZHQrNWhtRGZyR3Zoc3k3aFFEK1FCVU0vOUxPZUt5TVpjNW1oN1l0K0V3?=
 =?utf-8?B?ampZNEhxNlI3TnVCSEl1WC9iTk9XdGE5a2JtdmZNU2Z5Yy90WlBEYUU0Y2kw?=
 =?utf-8?B?L3V4WXVWQko2c2lWbHFRZnBodU1JZitjRndJUHlkQkp3UzJFc2g4QzAxQ1pP?=
 =?utf-8?B?L1N0aEc3V2crcUVQZ2g3Y09SUUZRMUhNMFY0aXh5RzMxVmJuaXUrcVdNeGVr?=
 =?utf-8?B?TVkrVFFYcklYZWRMZFlDNnI4Nk04L0NjaDVNWVNrR2FucWNybk5tV28rcjJR?=
 =?utf-8?B?UE9lYzZ5am15TERmMmtvelhsWHZqdEE1M2hhL0ZRS2FxYnJUcG4xL3ZzYy93?=
 =?utf-8?B?YkdZNlFUazBFNUxLM0VEQTNuVjRiL01xSzNNdHh5dTJKV3Q4eU55STlOZFVT?=
 =?utf-8?B?cldXRnJxbG5ySngycnlRTS9Pdm16cmk4V2VNM3Nsd0dzaEpsWnZEa0RJdzVP?=
 =?utf-8?B?WllWVVQxSWpvYS9vMjgrNXd3ajFoNkFkNzIzd0RBNE1Pb0hPK2Yxc21CcWtD?=
 =?utf-8?B?Sy9UWlNxOGtmUmlHdy9aelpOeXlYVmtHM003dkl1K2Z2dzdud3BwL01OWWZN?=
 =?utf-8?B?Y2hhKyt5Mk9JZjFSOS9EZ1ZkbHFYYktjU3pvMXdDaXJybnNrcnVVZW56ckVZ?=
 =?utf-8?B?ckU4M0RnZFdZY2RlOEdHQjJ3TUdmVDJwRjgrbjJCUDl4ZE50cHFGZFFVVHdN?=
 =?utf-8?B?b2RqWFYrOUdVakZYNEpMNmpSWXBMZEpwajVsYmtuYkk5bitmbmJZVDF2clFG?=
 =?utf-8?B?SzlpUUlyUldYOEVESVdxMXVtV2JEU1dlbEFRbVIyODRyaU1VNEppWUg4ZWxQ?=
 =?utf-8?B?ZHNRLzE1TUE2bEhHUnpNWkhIN1M4Z3A1akhTRVlmZnhmdGJHU2RRdG4zMDcw?=
 =?utf-8?B?cXNITUtuM2VSOHBkcEljZHVIYnNqcGVJcXZIOHJjL0pXdC8waGszZzZFWG8x?=
 =?utf-8?B?NHlqNU1yY3dUTnoyWXJ2WGVKcUxqbnRBWHdtNmxGTERGbGI2ZHR5U1NWTFFT?=
 =?utf-8?Q?pJJQd2tdl8510TOU6b0Z+yvT9Sa8/rq3lBaxo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06737b89-0e3b-42c7-7818-08dee9c47f8d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:45:29.7945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQXNZx+tWqadzfwguHWyEAvsDGGnyjDwfOBsVONT9k97zqpKR7hLsL9mRgUBMUMx6MHOFlaIgfySUAgscpkgeQj4iSI7B0P7vJLv9e1F9Ks4YdTM0vyXYO91iREQ6FLP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239
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

From: Frank Li <Frank.Li@nxp.com>


On Wed, 08 Jul 2026 15:39:50 -0400, Frank.Li@oss.nxp.com wrote:
> clean up dts related display.

Applied, thanks!

[1/2] dt-bindings: display: imx: Add deprecated property display and display0
      commit: 862de1b7ff9a3ad4151ebca050a4f44d8be83f9f

which only impact old legacy platform, So I picked.

[2/2] ARM: dts: ls1021a-iot: rename display@0 to display0
      commit: 6db9b23f3c0ebda050a4d38fda2b59db146ca161

Best regards,
--
Frank Li <Frank.Li@nxp.com>
