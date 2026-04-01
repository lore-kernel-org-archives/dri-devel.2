Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B3D3515E
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39AD10E394;
	Wed,  1 Apr 2026 09:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WOIAKrrk";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A597810E394
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 09:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLjDVwdUURAO7YEc69+zPU1cc0w42BKiTGwEfTL3Huf7W1AxOOVp9ydlyHX1S1754me6XSAk4s1z0emZmvRp7TM6mMJ+T493PAofzuLbQlqAtphIK5JuX05QGZtiO3xOWVndnDtqsO1Gt9xzyLZCY7nJg4IIqqSTXZ2JvZWA26B7dTmj23qbPqwhF4r1k0ioYYVt/fALhS2axF6wT+Jz8X5mMTsl6jFy3uAFHF0usGKAluYts4pMId8KNqatIJVLJzFc9A3P1fwssVx0Gb2rPEorsXOibZ7+IBRKmDmbjSV6Eyqi0CZ2frxdyO9TE2qg5crWs2kIm4D0Pkdn8vGcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75U3RpUJe+FVu9VwkhE9IsRV47CguUBmni07peFtbCY=;
 b=kvlji6GLu9xFdyKreMZ3ZTyaYPGeoGKZm/HyNgBrODiZcDwGysc5iPnxvcSlowknUZ7YCgGNPp9XxS5PmJkyj2S2cHeuO5dTOXBlCckPQ3NMcIhTmyTRpAO3Ctu2+jM2RdKrpFBErp6y2KdL0BUrHiqTzHLYEh0OuALFr3OG5+KBBRMZm1CD3Auk8lEXQBvEUIBh4ql1TOXazuPZ9ZAykJDQSloHiex6xbkFAGQTmjb4xHwb9nj3f3ar8D14+bxJRpiPaTZYGF/eTbb1oZwbsd8Qpk9eU/RmfUjx40isI97M3XyNAzFNx6ngHMs6cAPHo5k9f1t/udR5vo+9/sEgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75U3RpUJe+FVu9VwkhE9IsRV47CguUBmni07peFtbCY=;
 b=WOIAKrrk4NZn0a0aBOght78yEMOnVDlYylCE/HjHsxGv4RVxWIQz1thnRz1vDiKkcBrj5mdVHltWi23/rKwdm74kakmgPUfHQtmHXYAi0mbJZqhxsbj4OepkpSGMnZy3BNjwjmfqSmh7jw1GTtvkME4zbWoFAl5AmScxCcsmV0fr+UDfXL8P5XAzyUTj+8JWRHXUh+il/2Jry8G1YdxVJ7iEs0PC8M2qQVUPphTFh6ZR4icsR3VDbW2nUKv8cQL9f2AQQ9UiDDZm3tdyrhDzxU82Rdjpwp46n9z8aAobKThmfVqnFgYIvuJnWzEqtyD65E3Xj6p/0otCgYl6jJ/Mfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by PAXPR04MB9188.eurprd04.prod.outlook.com (2603:10a6:102:222::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 09:16:45 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:16:45 +0000
Message-ID: <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
Date: Wed, 1 Apr 2026 12:19:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
To: Guangliu Ding <guangliu.ding@nxp.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Jiyu Yang <jiyu.yang@nxp.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com> <acva1Xt8V4k9-uG8@e142607>
 <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0626.eurprd06.prod.outlook.com
 (2603:10a6:20b:46e::35) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|PAXPR04MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 49620847-da81-4d2e-1e8c-08de8fcf64e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ri/bgjsw3fiRj9P2mC9KHYlkzXw3mSGsPKSWQXOUdJJarbLHVBiCHTxNNgJHrrm5yhD9cqbF9G0LVI8rIavmvHEMuO/BkWvZJkJp39Bb9XTFNI2ad2Vpn+p0L65wOHa/TAU/eqUJPro5JQO0UtQ4RYXZ8nfbusuy0dqz3USv5lLH76bZPme6g6MFyaT9C13dsFUQoloR0DNA9i+R1w9/Fr7UOmGxtZErJ02wlg9LLQPi4WNsuUipMBEyyS9mnRGW1ROY6//P7x+9Ws/VUE3qps94NarsjIj/3yqCOnmB2y0jxIjfiSn2JK4kIbTplyxK6GjB03yzavVrxWoaUK8aeRXMJNpTtUICS8sfrXSsVZqA/XnCzs3+DCvetjGoMNhUbW2tcsMFLfkCR93LYtsWFEezxoyHYUM3LWW7/Y1HlXEBMBewgZ8a/NjvAUUt1Dvk5WW3i6jOGcPNiDLfIk35T83fddlvCbkrZ74RtJZ3R7R7m0H45riS5YXb4J4lJs2KdMN+peJwU/UbZ3UDNcKX5zmzIgX+IO/5oZQFkow6O2fC/k9t+uKlE1yF5kzdz0slsPhvdqWRMYjzooh0Ib9QQIQ/xiOnsFDlPn6NVuMC/sfmTk+VwskwjZ8G6tpVGZnTJ0j6Yym2iLmpcNo2C4RWCYc8JhdLI2pw40dwEPUgJdnp1w9AIe+bjxEqwFI8vh+V3q5BTf1FtQhdcdu+s+UQHxwij2XrSAXdeatN8OYx2mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12316.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHM2QjY0ZGhkNzNRMDhLTmNVMVlINlFyNlNpN1NTbmxQeFBYRDJ1UHRtRWVn?=
 =?utf-8?B?bTBEUlUvczZsU1pMU3FHTGs5NkdHZ3gwMElraVNkYWozQjQ1V0FZZlNsblkz?=
 =?utf-8?B?QWJxT0RNbVZOWEQyOXJUTkgrekttTGZKVWFWYlVMNjhIaGc0L25GYU9scStj?=
 =?utf-8?B?bHZMdzhOdzUxeCs4K2dQQUJqbVdsUVl2V21yY1d0dDJ6alkvWFpNWXZzQlhO?=
 =?utf-8?B?UWVDaHREbFltRUtYdUZHK3ZJVmlQZklHNlFINCs2bmZqNzh5WlFFYWNHNUtI?=
 =?utf-8?B?RkpEUGZxKzJOeHg2WDVRdytKcnR0aFhpQVVEa2xGOGxoUWhQaFg1S0dhTTVW?=
 =?utf-8?B?QmRmUGZZdklqQnlWUUJQSG9ORzlmNDQzSkRaUGZTdmdNUEt3eE50emFwYm1u?=
 =?utf-8?B?anp3VTlnMHZ2Mk5VdjB4Q3BFalc4Wkx5SUdZdmhQMmRpSGNrMkJONmFkWE96?=
 =?utf-8?B?RDlSVmtwMjJsTENpVlNmMlZOM0FlNVVSRWlZQXhYdUV1OUFkZXQ4Z0dydDlW?=
 =?utf-8?B?UXRadGF4M3NiMWhlOSt3Rlc4TGUzRWtOWjRUY1pubWE1bGxxWE9oYU9PSEZu?=
 =?utf-8?B?UlRBcEJ0UW1aRTR1Z0dFNjB2K0ZUNVNOZGF4Ni9rdlVueCt5YkJaSHU1SnVV?=
 =?utf-8?B?TWM5UW55QkhtK2NiU25GUEhwZFM5OGM0cXRqbEFhZDZrTVZiY0ZsQVNCenFw?=
 =?utf-8?B?NlJxWnNqNmw2azdKSGUzY2pBcnFKaGVPRUc0SUg5VHhBOExpZ1M2RVUxK1k4?=
 =?utf-8?B?bUFuM0NBTlgrZVBJMCs3UWNBTXVUKzRJeVVPdUErUGs2OGd6Y2xjS0IvS1RD?=
 =?utf-8?B?cDFWbHpTZUVwcGZOanRuQ3lhTHNncWFKL1lpUW5iSzU2MTdxU3c0SVFHUmph?=
 =?utf-8?B?Z0pWK01KNjQxOXlueTFibFpBNERCR0NpMm9KUVVzeHIwNm9oeGJLTFJGbTZ0?=
 =?utf-8?B?dXZubDFaRWRCYWgyZTNyUEk3ZlBkVnoxdTBZYlM0OW5tWWxVdlAwVC9RK2NW?=
 =?utf-8?B?dHFYRWFyUU80S3ZwUmZrcUoyYXJMOVJQYVR6MnRPQ05ISWJyWS9wZ3Q0VjNy?=
 =?utf-8?B?SnlLWEpmSTFCb0tHNGpFT3FINldhdmRQbTIvellMM1UwV2N3UjJqdFJ6ZS81?=
 =?utf-8?B?U1BQWEFZTmFGMzhtK1dkQTl6RTJ1RlFBVWppdk1JTTBOdXUxaThvRUdIUnR0?=
 =?utf-8?B?M1lNVTBVYmFQMWZ3cGNFT0JPcFhKdHJRVHpoK3hPSWhqbWR0L3o4bGhSMndH?=
 =?utf-8?B?azZhbmxQTFAwLzIrei9qOWNMQXdWVG40YmViOGU2c21VOXJLUVFNSStBUDh6?=
 =?utf-8?B?UWozeUlXOHdtN3pUUWFSSEUvejF5VUMxaDFTTEEzWWRnSFlkOFJBcGtidm1H?=
 =?utf-8?B?L3NUeTNDUHNlRzRZSVlaVnJ6T3BrdkhlSFVjOEozWVVINHdWWVVkaS9qclNL?=
 =?utf-8?B?ZTh3dmZnaHduOFNjRkt3SjBvTm1jdWVqME5LeGVFZE84ZmNnN3hhM2R0bzFL?=
 =?utf-8?B?Q2pOUERqcDQ5emJsbFg3dkdicnMzSUFRLzJFdGpKTGRrY0JJRUZSWm5JKzN4?=
 =?utf-8?B?cnFYTmVRd0lYaVpSRWx4RksvRzRPTVFvdlJBYVVvK3RBRFlpNkVrQnZ1b1Za?=
 =?utf-8?B?MDhIOVBkTk0rNXpha3BDa3ZCTmpjT0RkN0ZHbjZQdUE4UDlucFR4NjVVYTVk?=
 =?utf-8?B?Tjl3Z0xWZkRtNUJZOHo4M2MxR21pWklvMEFNeUFhQXhneHNvenFzMUprQjZY?=
 =?utf-8?B?RENLUlY0RmFpT1JmSjJWdXBJTjRLNGlkRnVzTFJkcVRuS3p0QmIzMHlZK3Br?=
 =?utf-8?B?dllEV0o3NWFuci9qaW5kQ1grcHdvNFRRbVFQakxUU0ZoeTU3YWp1QUtPeHFt?=
 =?utf-8?B?RWZoUC8yUWtjSHMwVlhaTUhQa2VaUG5kSkZaeDBXTGZObFZzanM4cklJZkgw?=
 =?utf-8?B?Z2JLV2tTejAxQUtnNGl1L0w3bGR5RWt5YmpZMDBHWGNmY2I1M1lNNUN6b1NG?=
 =?utf-8?B?V2J3R3UxWGJOb3ZwQ0ZpSVpLNTljcVpWWmxHbmw2dEM3ZGRHdjlibEQwam84?=
 =?utf-8?B?SmxUUHlwS0R1aUl0dS9tVnRmUGFPTW9rL3JscXhzL1phVnpUaVBsVE1KZVdm?=
 =?utf-8?B?aEdpb1ZEK2lTTU1RcURFYjh1NXNyVHNGcExQWDNtNngxR09nVWZQeG5QbG9W?=
 =?utf-8?B?MWlLVHVUenQ4Zm1sdi9mTy9QdU5rdUpmUHpzVm5CdTRISzhyMG5UTDNrSS90?=
 =?utf-8?B?Mk5uOHA1cEtDZGlwdDNSSnNScm51b0Y3U2h2dFZtVnFVSHpoL0l1R0h4RkF3?=
 =?utf-8?B?bzNzZk4rWE9pWUVybUQ5b2tpbGZUSmlEZWlXc3pUWVdDaHdhVnFDUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49620847-da81-4d2e-1e8c-08de8fcf64e6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:16:44.9363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVGb3GtzmMomaVg26r0LoxCc9rWTVSRh5Lc+D1XoRPoXBAGG4QsMXT31YsMjLanaX6v3JJ5pRY1I6rvq95OsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9188
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

On 4/1/26 11:48, Guangliu Ding wrote:
> [You don't often get email from guangliu.ding@nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Liviu
>
> Thanks for your review. Please refer to my comments below:
>
>> On Tue, Mar 31, 2026 at 06:12:38PM +0800, Guangliu Ding wrote:
>>> Add compatible string of Mali G310 GPU on i.MX952 board.
>>>
>>> Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
>>> Reviewed-by: Jiyu Yang <jiyu.yang@nxp.com>
>>> ---
>>>  Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
>> b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
>>> index 8eccd4338a2b..6a10843a26e2 100644
>>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
>>> @@ -20,6 +20,7 @@ properties:
>>>            - enum:
>>>                - mediatek,mt8196-mali
>>>                - nxp,imx95-mali            # G310
>>> +              - nxp,imx952-mali           # G310
>> Can you explain why this is needed? Can it not be covered by the existing
>> compatible?
> There are functional differences in GPU module (GPUMIX) between i.MX95
> and i.MX952. So they cannot be fully covered by a single existing compatible.
> On i.MX952, The GPU clock is controlled by hardware GPU auto clock-gating
> mechanism, while the GPU clock is managed explicitly by the driver on i.MX95.
> Because of these behavioral differences, separate compatible strings
> "nxp,imx95-mali" and "nxp,imx952-mali" are needed to allow the driver to handle
> the two variants independently and to keep room for future divergence.


This information should be added in the commit message explaining why

the change is needed.


But then where is the driver code taking care of these diferences?


