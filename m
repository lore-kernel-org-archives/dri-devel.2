Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940B606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=WaRH0PzY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D008710FC9E;
	Wed, 25 Nov 2026 14:07:57 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn19010000.outbound.protection.outlook.com [52.103.66.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDB710FC9E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUO2WHSf3jrPLUA6HfZsNJU4pWgRm4dtXwk5No2v3pfZuMHj1/M9fDN+4DTudPXIU4p1K6qhXS31TKB4HblcyvTJTZPPa0jyXx5Ps7lzkLygd0jGI/au9x+8DDLPe8qhshnfGFfm73kJCKoFdE+dy+mwf4yCu0DDK41hjE+/Wa4rYPOosxjT9ZobTB5ig34l9lMAoRvh+Uyo7GfaXlMIppdjsJym8VXrDXPkpN56joFnMeHTqsimzbqlz6tKxpt2E6g2zaoBW4i66qU1nvWMfNaIFzTOFHE4r+yBtOUdrmTxEErhCnIKdwUZvxhVkXiD9pAYr51KGzIVrwt+ZXQtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5MOs0VDKX03xGalb9YLKiFU+xO0QZJOrKoLqG8AHhM=;
 b=rV5qP69hqzXmfEBjKkKg9ghVf0ANIWokj55hUaVGHr/2CaP1wXV0WS97N5li+2sO3yWPaAWY39pqN6v5j7i4hNn4VKBSesu6mMTLoRv7oUugVKlJKIMuWOm90Raaz1Jemm+TghR9FjkSgncW7zh+qXGX87mHY6YTDFVEqhl7nI/RUtpNySFidgLCWzW+GnXQunrN/a/XFrz5I5xCJ5sOpDsOOwjltYybZ4AmrHaK1TVqDCXwN4DSogcc34xHSZVOsbN5SD9iQh5VfAiE5L6TyY1i9jBalZcTip5Nkemijf/JAJmoHyaAT+qu6vkzQz+Xzr8c8vV+0xVQe8Wy3prRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5MOs0VDKX03xGalb9YLKiFU+xO0QZJOrKoLqG8AHhM=;
 b=WaRH0PzYS8AwQhX8JALiaGA9oDWET9os53ceCS0GUQjUaEjzJYGeK7oHScLtJH1YOKR0TjE3EekpoWlAoc0TQT39tiGIXWIBvtENnMsfZwOS6F99VV3NqF7rVKmf5Zx2c8QxiiJluXOv4igyVVUaEZExiFvHvamyQq3U4s42XaZpKKENZ65I4tyLKO48POCPZJiBvwJnhmZJ9ZGYWie1/i3RHLPe3RBxYrxHfHuAachXGm435LPhggpBsMcQ7+kf3LQjUoZ/TPtNiAV5T5M0YOtBvCtbTaKnRH6zzhkYYC6o7zz+wHlMx2L3s8o3Akz1MFsAqviIGGAR/AEWHZJ4Hw==
Received: from TYCPR01MB11607.jpnprd01.prod.outlook.com
 (2603:1096:400:37f::12) by OS3PR01MB6708.jpnprd01.prod.outlook.com
 (2603:1096:604:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 14:07:48 +0000
Received: from TYCPR01MB11607.jpnprd01.prod.outlook.com
 ([fe80::def3:5bc0:3bf5:6e64]) by TYCPR01MB11607.jpnprd01.prod.outlook.com
 ([fe80::def3:5bc0:3bf5:6e64%3]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 14:07:48 +0000
Message-ID: <TYCPR01MB116073209E90F9228C373B90D89432@TYCPR01MB11607.jpnprd01.prod.outlook.com>
Date: Wed, 25 Nov 2026 22:07:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbdev: radeonfb: reject a zero pixclock in
 radeonfb_check_var()
To: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261120175413.176249-1-deller@gmx.de>
 <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
 <a2ffabc2-4096-4767-8124-c77e5dd79564@gmx.de>
From: Jianqiang Zou <jq.zou@outlook.com>
In-Reply-To: <a2ffabc2-4096-4767-8124-c77e5dd79564@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEZPR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:101:10a::20) To TYCPR01MB11607.jpnprd01.prod.outlook.com
 (2603:1096:400:37f::12)
X-Microsoft-Original-Message-ID: <a13c9730-9545-495d-b9f9-808ad993dc8a@outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11607:EE_|OS3PR01MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 646136dd-2805-4971-649c-08df4afd7beb
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|24021099003|25010399006|6090799003|8060799015|19110799012|23021999003|5072599009|15080799012|8022599003|3071699003|3412199025|440099028|26104999009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0xxbmpIUmNXZWgvNHBHWGF5VWtrT1JFRDZhYjVEU1UrL3N3WHlRZmpNbzln?=
 =?utf-8?B?SEdaSExtbllXbTZSQ1FRNmttQUhybEkzOGN6Z1RXWU1jWWJ4NitaNEZaaDZO?=
 =?utf-8?B?M3NwV2dDTGtUcnhJL21xcGxPZzh5N1hwRy9pTjFrZzNlRVBKVzNJYnZES3NC?=
 =?utf-8?B?cCtLK28vb0FPdHBoY3NJaUdkK2pWd1pYbk5LaXhERGZYdW42VDJOMndEemp4?=
 =?utf-8?B?aXk5R0VoUGhzT1JMVTBkLy9VeHRZMVkrMXFqUXVLVjVSbWhmaUZWK3lNcGVp?=
 =?utf-8?B?c3prcDJqbVBUU0lEMzNvcXZnK1VWWXgzQzJjUkxXeURnWEtHRmhQekhLU2tF?=
 =?utf-8?B?OVk5SEMxWDBPS3VwYkhvUXF6Z0JIQVdreGJnemRBSW50dWlxUTNOZnl6bWZ0?=
 =?utf-8?B?cGpsa0s2U3lreEF5ZUkweXg0UWxPMDIrNFAxRWVmYUJEZU0yZ2lIMnhHWjNJ?=
 =?utf-8?B?NkdmbWZmMjluZUM3bnkzU2pXWDdxbHl3QXE4b2U5ckJEd1B6OVV3MEI3NmMx?=
 =?utf-8?B?aWV0RURncFBIR1BEVXRhY0cxR2V4YkZHM1FabXBzSElGd3IrKzB5RGNhYzlC?=
 =?utf-8?B?Yng4YTk5L09qWG5aNHZJenZOVzhnd1VLdlhKWXRxc0wxRnFGV0N4N2ZXSGd3?=
 =?utf-8?B?Lys4MlhWVndDeEt1aU56UTBFS1UwUnFPaURDWWJQbm1ldGdjbG9BVC9UNllQ?=
 =?utf-8?B?VTJ2eWZYNG83YVo4aGVoK2VjMmtBYXBrNFZlTUdSTmF4VjAwbzVSdWRnZGpC?=
 =?utf-8?B?U2svWW1HMzZ3R1VHelBRZzI3REJqeEM3b1pvOEZ2R3RhRGp3M3F5bmVnNlZZ?=
 =?utf-8?B?MFZqcWlYQUpPbWJENjZWbk5OU0MwVi95cU54L3pLRVl2RzZ5a1VNVTNGQXBw?=
 =?utf-8?B?c096WnFNWVgvZ2xmR3FHWGpwd1FNUnZVSGlqaVdkMTlvOEVRenRWeWY1QXF5?=
 =?utf-8?B?TG1ybkU4OXEyQmNyWUg4NXJZZHNUMGF5b0ZpMlI1Q0JHU0lONDhtQVg1WndH?=
 =?utf-8?B?cGpEK09oWUJoNWJoZSt2RlIvRnFqaXJwenBJWjY5NlVPVjJCa2Z2cjFTYXF4?=
 =?utf-8?B?MzdKOEFVZmpJNFE0Nnk3Y3pRSktzOGQ3THB0cDllM2o2SXpCcVdtWWo5QlRx?=
 =?utf-8?B?V25NV1lMUURGY0lPQ09uWE5yZmhDRnJlZU80UUJIazBJMlBES1B4SFdUSjRC?=
 =?utf-8?B?VGZLeUh1UG1CWjhyay9PNFFGMVVTQUR5R0pSUFpoZzhIbEtnYXhxK2hMR1E1?=
 =?utf-8?B?UU5LOU5SWlVkSDVQTVRBbjVlUFpBOGNPNkZtL3AvbGp6VmhQdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck5xMWpQT0gyOTB0Q3QrOHdWOHlUK09vZDJFRmtMVjhnMkVNZ3NKN3UrUmhT?=
 =?utf-8?B?VHdkeUttSjVIVlVQNExpZnlreWNCc2dZdC9ZeDJvbDRzTis0ZjFaSXNtampZ?=
 =?utf-8?B?SnNiVjFiUHVkT3lZdm52ZHd0RTNBMDZHdFc0dEc2eWdlOTVnMFNEY0NlWUQv?=
 =?utf-8?B?NXhJYzEyOUFidVd6ZWw3LzlURXRhWVM0K2hUR2lWeURNdHhpak9yOHlTb3RT?=
 =?utf-8?B?eWdLcGVUSnNQMTViTy9CYmZQQ3o1Uk1keUdHZmlYZ1VINlZJdE5TM0RlYll1?=
 =?utf-8?B?M21TU21sdC9DOXE1dGJLbDVYKy8rc0NuODB1a3hLNVVxN2dBc28wWGtxTkpt?=
 =?utf-8?B?eVprUGgvazBUbmVjM3dZeTVFOW5tVVB1WlFTT1RPUkRGYWRlUjB6Ly84TmZl?=
 =?utf-8?B?VHU2eHFZN1VWa29yZW1OL2I0Tkl3a3NDRWhJLzdHM0oxT1pVNTBOdEFWWFpr?=
 =?utf-8?B?dW4veVAvcjJmRDRuRUh0cFZ2ejI2L0NrcGNTclI3WGhsL2VVT0Y1cUUwZnNs?=
 =?utf-8?B?a1BFWEI2VTlSZXl4SWxaZFhIT3A0QW01VjdwRFcyWnR0VEdaMlVsbXJMaGho?=
 =?utf-8?B?Znk4MXVjbHcvTFBHK3JxYlp4TktRaHc3em13ZXBhNExlU09PTk16SVBJcERl?=
 =?utf-8?B?VTNyN3cwQ0ZFendhcDhEMDRwVktsU3phOGd0K3hZeDA1Rzh1eEZId2owUldR?=
 =?utf-8?B?bUJQS3U4eGF2Ty9Rc3RnU1IxTG9XdCtCRDk0SEFmMEh4S1ptMnJnT0Q4Tm1O?=
 =?utf-8?B?QTRQNzJTVDRHZzlKUm5EN1FaMUVvR05SN09lWG0zWmQ0R2RhdXhTVzlCVmdW?=
 =?utf-8?B?TVAyNkFTUEkxSmhtc3RlenR1ZFByTkw5d3pPdGk2T2lGWnBBSWZBOUh6clpp?=
 =?utf-8?B?bHYzYXRzRnQyQXhEK0V6a2JkNm1ZQVUvelZrVnpZTWVlLzZkd05rKzFVcWxV?=
 =?utf-8?B?elpxL05vRWxFTk1zOVZhMXladysxSFA2dUpnWGZyUXZNK01tUVY5bThzYjJ5?=
 =?utf-8?B?RWVpRG1YT2FGNk9VN3N1UlhnOHp4Wmc3aFQyeHBlbjltMGs5aDhmNk5xTmt0?=
 =?utf-8?B?VWREOHVNSVlvLy84QlZockVVUit1cHBqcG5hZzJVV3Z0RTgxcytsREtvTko2?=
 =?utf-8?B?NDFuTldUTUlPY2NsTS9HNG9yMDR6S2ZYYUJsM2drcHVRTDArbUFlZmVPNjZz?=
 =?utf-8?B?VEtoUG5ualQrUTJ2bi8vVmppOE1ITTQzdkVaaEU0ZTZsM0daaFpHWGR5VnJY?=
 =?utf-8?B?WFVkY0FPb0lnTDNjcXBFRHhzT3o2NXlNT0lHMGxKbFJ6SEdtU2JRVFlBUkVP?=
 =?utf-8?B?RDZRTU9EY3VLdzYvVytzMGpOUEQ1VWpTaVQvak5GSUhIeWhZUjZSRnY1NE9h?=
 =?utf-8?B?QWpZc2gwTW1lMnJMOTdLbi9LcCtsL04rd2YyRDdjbEpyUVFPWGFMSUU4MUZV?=
 =?utf-8?B?S1NLeTlOcWMrSHJJWmxPOFhJTUxMZEhpdkkvd3lzYzhNUVVBb24rVTEyVjlm?=
 =?utf-8?B?OWlNaDZZZlY0MmQ1YzNmKzhvcDZmTklkSmRNa2hTeUs3NkxyRStSc1pnZFQv?=
 =?utf-8?B?Z3JrcmI2WlVDR05uV0lRY1FFZ0doK0tWZzZIVlF5SzhpZGxLbkxsYjh0K29G?=
 =?utf-8?B?cDNsSVhzQnVNRGNMdnhnSkxsM0l1MkV5dXFXNm5QcG1BMHF6NmNBTk80cVpU?=
 =?utf-8?B?eC9Ka2tNZUhZc2o2NWtKSFYrb3ZMNG1JK3lrQ3ZSN0crT0NjdWVTbUdjRzMy?=
 =?utf-8?B?RFd3UEFhci9uZ0tXSGszY2YyS0ZPRjZKbUtCejNUZlpGbWg1eG5hZ28wbjVT?=
 =?utf-8?B?V2Z2S3k2SkdYUDVBajg2dmZRSTQxNjJLYVlEcnpISVVMNnUwdEdEdDg2NFZz?=
 =?utf-8?Q?LNjq7IFojrPIR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646136dd-2805-4971-649c-08df4afd7beb
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11607.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 14:07:48.3005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6708
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

 >> This violates fbdev API rounding rules:
 >>    1. If a value doesn't fit, it must be rounded up by the driver,
 >>    2. If a value is too large, -EINVAL must be returned.
 >
 > Oops... you are right!
 > Jianqiang Zou, will you send another patch fixing this?

Hi Helge and Geert,

Yes, I've sent a follow-up patch in a separate thread titled
"fbdev: radeonfb: match a display mode for a zero pixel period".

Thanks for pointing out the rounding rule, Geert. The patch uses the
mode database to round a zero pixel period up to a supported value.
It includes a Fixes tag for commit b3f1631d3625.

Please take a look when you have a chance.

Thanks,
Jianqiang
