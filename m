Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA55C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FA610EDEE;
	Thu, 30 Jul 2026 07:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZsyC8Yws";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Sk/JDx7Z";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB38D10E00F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:24:45 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7h05p1824087; Wed, 29 Jul 2026 03:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=/FXxZTXGpVwb9gevOECORG1Qc/3VRiZFfQIGmrGE7
 L0=; b=ZsyC8YwsQPnle1jEbV9iAa3pm8ZtqycpsH9Pt8kY67/iY1MG8gGI45SED
 Ve8vkouB5TNEvxYfkGZBjWhbfuJfwa9xUI1QM8zNJU4vSO0F0R2j87vzePK1Lck0
 8iVHo6xdt4SfDWmczHEypWCD8WDT49FG1YOQn9clAPqFOT5XqdZlZTg4x8zIOBvB
 Tigxu1tNE5+mcDUybXXJRn8v1PNzn607g+EALFLDJ3Zj+4BMV8+DE2Hk2IztOJQ1
 VwbRsis8mgu37AZCYM3A7/c873XjQKPKqGLWKH35jjOtbOvYcuwHRn88fl2+MOZP
 YDbqoQuoQriUD0VxLfPixrvmr237A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fpvexpp3m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 03:24:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5WSwvvxwtnGAFh+XRM7wSM+ajcQO0ZWCKGqY3i+rm/8p0mJZoNWYHETTCvdoXg5c4IIANsNMzB/KHP3Ziq0WxWBZHgLlLfScu1oMA8aawAPuk7lfrJs2fBGa1w8GnWyVdlzAKbPQV5vq0CSiqdIh40HHfBX+9XgiYRUO03w8z8wq5Eh+EUXpyJZQROZEbJQvLRCJ7OVnk/2/ZEdE7ZALYCWpDNY7P0dU7yMaj58TpzpUK4sOZ/vcKJGLMUiKArxpy21UwsI7bmjdICbE2Qa/WlYNuFRDDpIuPL91vkskjcAwwXNB7F94AfUmH6i27tiVftt4xaIBeLZOzWtB0jEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et8MZDlF6CkR1+NTZksLBGq4AQhSKt4f2gkcj7hGqYs=;
 b=C8Ja5/O0AxuFI9ErsJ+X4kEvxj43Fq8MssvJahxxm+B8fFO97ywzXoT75KXpGCMWN0L/LMQeRXhtbE9Tgr52tseSPX/Aiv6/zqHxAkQ550E1j7EGBmFJabBV6eMHrI4RMNZQtogQy45ReCrqldl80S3wmBweLoIMek+pXGZOBuonoCoFVDircxlSagitn9lZTGoF2YPcb8idCNvWtHzdHZUQKKtdT2bBp3TtqJMRKaWJfqxtzP9RPXI/8emSQqDrq5RlzWZzr42IqWgxEVb93vhm75MWnrWJlKw6ztGl1SkZskJyoZF4X2Q2uF0ukeGTBvdLIS+2BioujsL/PkMfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et8MZDlF6CkR1+NTZksLBGq4AQhSKt4f2gkcj7hGqYs=;
 b=Sk/JDx7Z5UZmtpdBoPNetX5nvKfR55kUB2NFkhLWNeuM2M1+exWsPEdD0lJ0yRsuKxyWy3TiXGH0uDYc+NEZqzUJdm/17Enux4UgjwHuArMNv2MvetEA00iFbTnISJ+8NBkr5gNwroS5cqEc7wVs4QFwvc2WLZr4M+mI7ac7G/Q=
Received: from PH8P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::9)
 by IA4PR10MB8279.namprd10.prod.outlook.com (2603:10b6:208:55f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:24:41 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::83) by PH8P223CA0017.outlook.office365.com
 (2603:10b6:510:2db::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:24:39 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 03:24:09 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 03:24:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 03:24:09 -0500
Received: from [10.24.53.80] (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66T8O7vY917122;
 Wed, 29 Jul 2026 03:24:08 -0500
Message-ID: <ce9bb75b-bba9-49c4-87d9-28b499aa6fb0@ti.com>
Date: Wed, 29 Jul 2026 13:54:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dominik Haller <d.haller@phytec.de>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
References: <20260728125336.776116-1-y-d@ti.com>
 <074a97451488f0e6d41afe968e9248399dffa88e.camel@phytec.de>
Content-Language: en-US
From: Yashas D <y-d@ti.com>
In-Reply-To: <074a97451488f0e6d41afe968e9248399dffa88e.camel@phytec.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|IA4PR10MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 58af1acb-de55-450a-87b7-08deed4ad58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|56012099006|4143699003|10067099003|3023799007|4133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t0auIK3D3PceJOMEiGO7eCLWO9gCAY928khBkq4Wd1azyNZpUQSpOHgucdJ8ecPyH8WSyVRg8PU/w4f+KoL1RnrUZnF6WTgGmMt/euHppq00RIgqhNqiLkONQu3vY82Q485kHc5WDdZ9Gik67Dy23zFL8c0jsTWmtbGse4hd9sUY2WBn/8EyM6TPEzct9as6F+Dft6rscWBJf5aDI65rF+jMMtHsm0Rfd0hLBYOhSkqXsFLB7WtQrdTx8dloqHyNv9N9+/AzJKY/bH/j96btfW+X77TrLeop4FvbE2a1eTZJYhfZf4rUOmA0mPDcOUSD40H/J2YB8k32Of3696QMNl8qE6iJjfDHBb7TUVVnaUsersSNrN6356LHXuBEok/esOim60exdi1fntCwR9t0qSWftlXfE60PaesjrszoWyPMFeXOVlnNcg/RIcaEHelF/TOFpBKKT0OdSJlQo8fx3sWenoGANQ3v0IKtvzwhuIj+Q/4Y6f9mN/E2+sikKVV7TtBMG8WnJ6ApG0GRcPG9ArjbY/K9XBeaOWYyxDYO4glkY1YGo9iS16AQo7jENBDwSpymN4QtA2vAj+hejlhSYNJidJzJqC9KKGeBLaUzgK7OK2B4/TLxgohAmZEwokmEiFferhccy82zjp2+W73bJg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(56012099006)(4143699003)(10067099003)(3023799007)(4133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n5NUnLGc68Yh3JgDmJC6dngAJdxNe0yJVWa3VX3f2IVPb93RqVKOQf0RE1dlsty3lH6BhjDc8j2oN6mq/cA3mW3tkj9B3YkiVIQCgpmub9IhAwlQlkVZQlMjQhjWi4s3lbFL6cRENmAlHTpEedM2mojUHKBw4MwaPMe9Yf55oQwT+avdaubFIfj/t3YdexrPdRkwegDRZ4jE0iSGzhSkd16dgduGbEO4+TXr7cm+UUawfAB47XyM02ANstFTqqAjOPCAG/B/pVdDH0w7Axsxq4BBibe62tFEbduzdbXlw1iVPTls5GLwkbSsI1WSJwzSMY4jHkfWSsMy4YdqtZtTXrCkV5NOwmlZFZF7FcjuY7RE2vRL7/XcA5hqw8EzpGT9PFg+AaqiGTGabo0RBPJCfwRoBC4JbJQxqWuV5DLchn6YRQsaVtYHTSJzIWcCuxra
X-Exchange-RoutingPolicyChecked: f0vPWZTIa2kmra2sUDQPPDU0ISwH6MXOW60EJb3oKtE+oL5y75He5jpbQBqOORn/5kqvkLK7nW82pefFBChnHuqjSldQON2c/L+m9tmBgPk/Bj9Wk2m+WTMOyOLNV+0r5ZR2epG0cRsUymmT3WomFyAjanbE3DPhNZVndvSFOve3Mk8rgWI49m1YGbM/0JXhtV3NcW/E+Hl+/kZE3LLWcEiDDIrXH0SSOCs84kr8EiV8p0MoV1oMnKD5+//y9MQKx/t3q0LPu/VheZl7OASYQiOZJaoRJjOIbH7YTIn/wg6FxD9DrDPgSLJ23CxVcP4jn6ATnTzGtZdYeJXWQHxfmA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:24:39.8345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58af1acb-de55-450a-87b7-08deed4ad58b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8279
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2OCBTYWx0ZWRfX39mvAEybV/IY
 sm41hMjfxNGAzA+KCxqC5gHHOxb31kcN1hx+nLSygUpk3x4cSQfJw7+cJAAZagm/iMeYwNJoPlx
 i++v6ItiUtn1Qqspsm6Tt6uU3edQrVfRMW2g82Z81TgNUnM7W+UdmN8tthJ9X/pnr9uk6HJGVEf
 MtXq/i2wa5ITdCrr0+bfG3N1aAxBt1482aTSSdK8CrHDQNQFsFXOrryw54b7lu+5bbUwVebRgXC
 qoxrEXjZndcvSP5MS6M2rVbOYtWu+jXMsxHwXOlaguuyXiccf5OWbD/AEgN6xoetWCEWEbMXyBY
 DMsgd81YTRt6TprK9gLhuiZ7YGb2e7EUGSrxL8PoixnbtDgMfIhqrncxCJ/NjX66GBX/zjxxzP+
 cEbzwx8dF+L2zDh+bxICwvadlK6kxFs6hCCs9DjsKZ2nwPSeDqfdwwUzUX0cP2rDPJzLL7zdkKx
 Uxb90wEu/tUt/dJib5g==
X-Proofpoint-ORIG-GUID: p-HqFYRJyALUUKUKC8xi40ZpK1zdydQ3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2OCBTYWx0ZWRfX/Rkq6UG1kEGT
 UaW3xAmImTTTfXtkrFFmyG95Tz+xq+b2gLDXv/zkYpPJ4ZJcpVJ3pUq5JcJpxYIWiJG+RK/GLhY
 KiZE5VqZBbVALryl9wqqUacNwqHL5Bk=
X-Proofpoint-GUID: p-HqFYRJyALUUKUKC8xi40ZpK1zdydQ3
X-Authority-Analysis: v=2.4 cv=IYW3n2qa c=1 sm=1 tr=0 ts=6a69b8cc cx=c_pps
 a=Ie6vhHcvS3zZlrI9i1bNAw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=RpNjiQI2AAAA:8 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=mU5csN-mOLmHm7G86z4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Subject: Re:  Re: [PATCH v5 0/2] Add no-hpd property to the cadence bridge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290068
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:56 +0000
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



On 29/07/26 04:07, Dominik Haller wrote:
> On Di, 2026-07-28 at 18:=E2=80=8A23 +0530, Yashas D wrote: > This series =
adds=20
> 'no-hpd' device tree property support to the Cadence > MHDP8546 bridge=20
> driver for boards where the HPD line cannot be used > for > hotplug=20
> detection. > >
>=20
>=20
> On Di, 2026-07-28 at 18:23 +0530, Yashas D wrote:
>> This series adds 'no-hpd' device tree property support to the Cadence
>> MHDP8546 bridge driver for boards where the HPD line cannot be used
>> for
>> hotplug detection.
>>=20
>> On TI J721S2 EVMs, the HPD signal is routed to SoC pin AA24
>> (MCASP1_ACLKX/DP0_HPD). This pin is muxed with the McASP1 audio bit
>> clock; selecting DP0_HPD breaks audio. There is no alternative pin
>> carrying the HPD signal which makes it impossible to use HPD
>> without loosing the audio capabilities.
> Hi Yashas,
>=20
> this description is not correct. On the J721S2 EVM the pin AA24
> MCASP1_ACLKX is not used for audio.
> The pin is just floating unless this "GESI"-board with an additional
> ethernet interface is connect. AA24 is used as as
> MCASP1_ACLKX.RGMII1_RD0 in this case.
> See arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
>=20
> Also the AA24 pin needs to be configured as HPD pin (muxmode 3)
> otherwise the mhdp firmware will not turn on the bridge.
>=20
> Dominik
>=20
>=20

Hi Dominik,

You are correct, I apologise for the error. The SoC PAD mux conflict
on AA24 is with RGMII1_RD0 (GESI ethernet expansion board), not MCASP1
audio. I will fix the commit message.

The full picture on J721S2X-PM1-SOM rev E2:

- The HPD resistor is DNI from factory, so AA24 is not physically
   connected to the DP connector HPD line by default. However AA24 must
   still be configured in DP0_HPD mux mode (mode 3) for the MHDP firmware
   to operate at all =E2=80=94 configuring it in any other mode prevents th=
e=20
bridge from loading.

- When we physically connected HPD by populating the resistor, the E2
   board failed to boot with a monitor attached. The HPD line leaks voltage
   from the monitor into the SoC while powered off, causing a PMIC error.
   This was fixed in rev E3+ with an HPD buffer. Our boards are rev E2.

The audio conflict in earlier message versions was our mistake. It
came from investigating whether an alternative routing path through a
board-level signal MUX chip (MUX1/MUX2) on the SOM could expose a GPIO
for HPD =E2=80=94 changing that MUX's port selection would have affected au=
dio.
That is unrelated to the SoC PAD mux and should not have been mentioned.

I will fix the message and send a new version.

Thanks,
Yashas D

>> When 'no-hpd' is set, DRM_BRIDGE_OP_HPD is omitted so the framework
>> falls back to polling .detect() every ~10 seconds. Monitor presence
>> is
>> determined via AUX DPCD reads instead of firmware HPD status
>> registers.
>> The .detect() callback drives cdns_mhdp_update_link_status() on each
>> poll to keep mhdp->plugged current. At attach time, the driver waits
>> for firmware to be ready before performing the initial AUX poll since
>> no interrupt will trigger it.
>>=20
>> Changes since v4:
>> - Corrected the dt-binding Subject
>>=20
>> Link to v4:
>> https://urldefense.com/v3/__https://lore.kernel.org/=20
> all/20260630102610.1849902-1-y-d@ti.com/__;!!G3vK!=20
> XKetSJhTJzSznMTBeoww63bvXSPD3xrWstRrf4H6AhnrM5IjIvNFa9uHVVWEYPEoe0GNrZXGb=
8IF$ <https://urldefense.com/v3/__https://lore.kernel.org/all/2026063010261=
0.1849902-1-y-d@ti.com/__;!!G3vK!XKetSJhTJzSznMTBeoww63bvXSPD3xrWstRrf4H6Ah=
nrM5IjIvNFa9uHVVWEYPEoe0GNrZXGb8IF$>
>>=20
>> Rahul T R (2):
>> =C2=A0 dt-bindings: display: bridge: cdns,mhdp8546: Add no-hpd property =
to
>> =C2=A0=C2=A0=C2=A0 the cadence bridge
>> =C2=A0 drm: bridge: cdns-mhdp8546: Add no-hpd property
>>=20
>> =C2=A0.../display/bridge/cdns,mhdp8546.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 17 ++++++
>> =C2=A0.../drm/bridge/cadence/cdns-mhdp8546-core.c=C2=A0=C2=A0 | 58 +++++=
+++++++++++-
>> --
>> =C2=A0.../drm/bridge/cadence/cdns-mhdp8546-core.h=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A03 files changed, 69 insertions(+), 7 deletions(-)
>>=20
>=20

