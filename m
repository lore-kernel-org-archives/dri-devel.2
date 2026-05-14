Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CC8CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 10:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE5F10E145;
	Thu, 14 May 2026 10:57:04 +0000 (UTC)
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.109.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D530A10E145
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:57:02 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020074.outbound.protection.outlook.com
 [52.101.84.74]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-113-fRc-bBLKOVWWvfLdX5X4UQ-2; Thu, 14 May 2026 12:56:59 +0200
X-MC-Unique: fRc-bBLKOVWWvfLdX5X4UQ-2
X-Mimecast-MFC-AGG-ID: fRc-bBLKOVWWvfLdX5X4UQ_1778756218
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by DU4PR01MB12195.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:620::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 10:56:57 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 10:56:57 +0000
Date: Thu, 14 May 2026 12:56:54 +0200
From: =?utf-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <bstruempfel@data-modul.com>
To: Marek Vasut <marex@nabladev.com>
CC: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display/bridge: lt9211: Add
 drive-strength-microamp property
Message-ID: <agWqLjNdHxqvwTx3@DATAMODULBOERGELINUX>
References: <20260513133127.376458-1-bstruempfel@data-modul.com>
 <20260513133127.376458-2-bstruempfel@data-modul.com>
 <271d1839-e372-4f5b-84bc-29fe30b928a8@nabladev.com>
In-Reply-To: <271d1839-e372-4f5b-84bc-29fe30b928a8@nabladev.com>
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|DU4PR01MB12195:EE_
X-MS-Office365-Filtering-Correlation-Id: 8048ebe4-20a8-4026-8565-08deb1a78434
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|7416014|4143699003|18002099003|22082099003|56012099003|3023799003
X-Microsoft-Antispam-Message-Info: lyyfoOWzVPz9/mvvckoWC3/rRw4ai+9c/Hp2rVXgsY0/yoZsPdmEjLOqrJtoEXFsluuYg54XWwe0nI99xqP8xB6Mqe9HUUNPwhpIrA2rjL7t06mpSi587wJyLmGvvgmSyOBGWq6yZB5CgqbsOClYU/JZdHuvzE4z2VoJFZw6FpSQoTl50g02dSbg1WpNogNFZFEQaHkBGxz3rg/Rm1QffIOU2MJZjo8f9ub8D5BIPrRI2FVWD0eQTFB3ifv3GoVwvdwmjdOK9A2L61bA3ROZhvdIa+sCWQDsrHXdbKja7PFTGyuQMNPsIjsomwPvRzbH3FnG9a/FUgFeaxL5LLvD3YCs83TujMLHjpT6yQgNyu9thkvzq79zCYLBtpoEJCRhL7m6SFR/qMYPxGd4oRLbqIepA9HF3JNpQDQHmr1ZHSF3lPvL5p5RzvNjLScHnBA4gZ6m2Fc6B8LmBgCpFublbHq8qnrLdZ8h88N/9VarQyqkebFVcr/04zWHcQ3CZP+WqxEBH3Sx0EwbeEoM8Vmx+Ig5hO621dBAlD++Unr2K6ZxHjOyi8EGLEez6LzovSjR74zDtCDiQpJgsYT8lfCeX34DQVldGxzd4MJcuAZGZTkjzWuteX1fbl/Le1P0z8CE2pmYabSDeHtW1tNwyFT5E72NgskdtxSdCD7e89Iy4ab4bbuH934S9uaknPYoqQFI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014)(4143699003)(18002099003)(22082099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZSOU4rZCtsSkVuZjJiL1dxNmZpMXNBYXRrOTExdzRnNmdHQ2J6RHdTYlVK?=
 =?utf-8?B?RjVFZ2N1NnhNdmtuZkl1T0RFZGZnRWJkWkliNGdnVk5pb2FPeXBrVXlZNDNB?=
 =?utf-8?B?RnFTaDEzV0RIMXo3S2s3Uk9NZG5kV1lvR2t6NnpMVlFZV1F1eER4dGFGUjBB?=
 =?utf-8?B?YmE1K1RuQWZuemppL01ZUW8xQ3FrUzFNNldqUFdFeCtuZUdZM2Q1VnFBMVcx?=
 =?utf-8?B?ZDdvWXd4NVhObG5LTkRhRVpCZUN2eHBGTHpqMk1yOUlqN29NS1RtSmhsVmZi?=
 =?utf-8?B?cHFpS01KYWFNM3dPZDMwc1JGamRrQkJtQytHNWNjM1JveGpXYXF2UFcrOE9R?=
 =?utf-8?B?YzFnbFZUZVI2TXJXRWpZVWZoZ1JOM296dmNMZmFnSExQS2c0UEpDY2lMYmM1?=
 =?utf-8?B?RFdVTTY1dDFVZ3FnTWtlYVU0U01YVlp4MkprQTJsTUxYMHB2YUU2c0FNOVZ2?=
 =?utf-8?B?OGYyTHZ5SlUxa21oY3JNank2bHVrZzNSL0NZN2R6MmhTd2JURHNuSkdlK2Ex?=
 =?utf-8?B?S041NW1jeFR4aEZ5OFFualExc1RBODJGazlKQWhFc1NRSjNwQVRYS01mZmsy?=
 =?utf-8?B?ZkpTQUlaRlVIcGhLSUJ3VkZJWUdHUnJVdEZTY0JwaHZmaXI4R3ptVnMxV3hI?=
 =?utf-8?B?alhRczhvWUlvcW1UTGtmNVlSbE9nV3Z3YWE2TnUyVlhzNmMwTy9Fbnp4N29s?=
 =?utf-8?B?WndQaXp4cTczeWYrZzV0d0pwZHZFNng3ZVFRbVA2N09Iamk3S1pMUHozS3RL?=
 =?utf-8?B?WC9CUTJjTXFRSFZHMGVScVN0RHN1T0dINHhBSGY2QXliMEtxMXB3VE9VSVVE?=
 =?utf-8?B?bFJtSWxjQThCb1ZhUktIaGlxY3JvTW5CRTNueDd6ajJ0d0QwbldCVDJ6NzVo?=
 =?utf-8?B?VTNIemR0V3NMRUMwcFFxaWR4MCs5d0UrYkdXSm9DclRna2FXWDU4TWl5SlVi?=
 =?utf-8?B?SCtLQm4vbER5dnNhSWQwSkprTkdIUEwrNmtYQmpuOVRsNUZVcktYWHVXRitr?=
 =?utf-8?B?cmlzeFphdHQ2alNCYjc4SEdRL3pJQys1dWRqTWh4TEJVbjZ4U0xKK3hEazZr?=
 =?utf-8?B?M0QwOXpIN1UzMHB3NFl2RE9iN1NyeERyVTFZbndHalMzRWNEZmdtWFYzSjI0?=
 =?utf-8?B?VHE3Qk1ycjR5YnR5aEt3MjA4VE1lblV6dUJleFhTaDJFRURQSHNMaDA5UTYv?=
 =?utf-8?B?OWhPQUhxNWx3K1lIWDd0VjFHMWxhMWthVnpyOHJDcndyRzJHRW81RmpJVUll?=
 =?utf-8?B?SkxmTW5ZSVZjT3pMQjFTOUE5d243dHhGMmYzUytETWVlTDc2djN3UGhDZnBk?=
 =?utf-8?B?OG81dDhqNmFIMGVMY1Y4V3Zpa1M4M041SUFUTENKN051aUovYmd3QklNc28r?=
 =?utf-8?B?ZnhYeVJSZ3NUMkllZHhyRncrU3A4WXcrNVN1Nm9mMVVPWTcxdnB6RkF4bktw?=
 =?utf-8?B?ODBxRmhSVVBZcjJ4STdzeHRxQTRHVEdJOGZ5WVlsTGlBS0FmRnJudm5hMU1t?=
 =?utf-8?B?SkV4clh2R1hLZVAxZ0FMUXpDWUJVSXNjVDloRGFsVkZGZkZ5R1JZTkJJSzhp?=
 =?utf-8?B?QXdhTGh6WVZ2cGhzS3U2blZRbU1XcW10RHI4NXZsc2IrcHJmb09VTE0xdGtw?=
 =?utf-8?B?cjBJb3pLK2gvZTZOOWUyVUNma3ZKdklqeWI5TElUYmsrZWdGNjNLUDVpVUo0?=
 =?utf-8?B?bzVSTC91YzQzamxiRjQ3c3NXL3ZlQkYxeGJlL0tKdjBWZU9YNm1nNkxCOVpJ?=
 =?utf-8?B?S0J6KzhEb0tDb3JNWkFLTFJzaGUxbkIyYU5oR0JZRlRGYkJHdXdrZ2dVbS9i?=
 =?utf-8?B?ejBtSWNBV2tuK0JQZnhoam5GM2tQajhzL29XMVpjZEJ1TUo1NlByazM4WHFY?=
 =?utf-8?B?aXpZdmV1c1FUalVNV0d6cWZSU1BJVWM5R3U2RWFaSUUrbE9BZlZoZFVHaUxi?=
 =?utf-8?B?Sk1ucWdHWFlIbnJZR3dFaUp2ZnJvN0tydngwN2ZNRTJvZEVkMEN3ZTk5VXpL?=
 =?utf-8?B?TXJ0Q2RSOWxLNmxFazBqWHppU3IvTHA0M3V3M3JCS0NwNkxhSFVTL3ZnQXJl?=
 =?utf-8?B?KzBYdmdCSVdmVGtVSEdCdWNBWVhKRkl5RGpIRElFSU14S2lPWTVsdW9LNlNy?=
 =?utf-8?B?eVVkamtLVHl0OWJBOWlZclVuYzg4a0VRSU1HMkJIV1VIcVZzMU16SkxuMklG?=
 =?utf-8?B?cXlPUVZJM0hnd2FVckM4SzBXS1lUVU4rNlpWdzViZndsbjZTaHd1T2UwcmtU?=
 =?utf-8?B?cms1NFlhd1RuQ0gwWmwyZllsaVNLWmVvcVQ3N1l6QjZjbCt3K0J5VVh0YWpn?=
 =?utf-8?B?ZmlvdG04QUJ3UFRaSnFreEk2d3JhTFhmMmdLcWxsTEhPcjNaQTZRbFRLYUtR?=
 =?utf-8?Q?c9me9922+o+93oVNbTWT55j5noNFfm8KB+JAxtHWLk7wb?=
X-MS-Exchange-AntiSpam-MessageData-1: 1eNN/36lhw+viU9KmPKX8SrLs74QqzojCNo=
X-Exchange-RoutingPolicyChecked: jbPzwvQqU8PLM3SRhvHbHPqDFHQBN0dbANPnu/byFF+lxOuXnTy4O4rz34vPgo3qX3tO4rB9NL2GHMcIRlZOHgG3199HDqI0h1Czbl7HXTgSUfqO8ZJA8X1IRPlMavV8sp8MxmxYiVyyEhjBpK9GPaqRi3Pc4wMDcb92ndtzlM+3WUNCzmlK/xKrup9Qwk96/cmdZDUJDLuP4bGtg7qpo8arWSNl7XPTZeQ6hZn7mOWRLmgi1H+JF4gWRxOUBuDyLwjLP9xfInIrQxCYa9PBBK5K3EohBMagwOnQ6p2WHMToL2pNxKSlZYaEef07DIWq0m2pGPtBajr1oZiB0Eb8NQ==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8048ebe4-20a8-4026-8565-08deb1a78434
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:56:56.9749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHezrM8jSzKpMxySqQTN3XF0H8twMfa1Cmm5uIrs20jxLQYgH/qjNkfn+DHyehAgtBLEPRIBtxvcKgMx+LChnL18RlFCD/M/fIGlm6vetkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR01MB12195
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I_zQVOpCPId0SCaFxK__tHXK7ck8D8WrRVW0d0PVcZY_1778756218
X-Mimecast-Originator: data-modul.com
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 13, 2026 at 03:41:41PM +0200, Marek Vasut wrote:
> On 5/13/26 3:31 PM, Boerge Struempfel wrote:
> > Add the 'drive-strength-microamp' property to allow board DTs to
> > configure the LT9211 LVDS TX output driver current. Sixteen discrete
> > levels are supported, ranging from 12 uA to 36 uA. Defaults to 25 uA.
> >=20
> > Signed-off-by: Boerge Struempfel <bstruempfel@data-modul.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> AB goes before SoB line.
>=20
Thank you Marek. I will fix this in v3.

--=20
Best regards,
B=C3=B6rge Str=C3=BCmpfel

DATA MODUL AG
Landsberger Str. 322
80687 M=C3=BCnchen

