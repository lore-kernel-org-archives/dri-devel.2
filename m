Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0D606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VX7SY373
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7810810E99A;
	Wed, 11 Nov 2026 14:39:16 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn19010016.outbound.protection.outlook.com [52.103.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF6610E782
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdw697q0DD4hhOTcMNARanj520wOQNMQt3V2Gm6Ze3Ge37fZxPb6zI27neI5oOgMurBBoM1QBIfrYRFQTgUmhOGVEJ+NK3o5cU94i4YBHMW6PpRdbrg5A/He7MUq6Y4UyKH+lRcyEn1Scs2pqjrBKVoDUfraQ5orMWkW+S710SDx9gUWFgqPGwP+K2OHOQzlPaVVE0IHbKXCDXhQqO5PcQnKPJZMKhjMYq8gbPsjKu3eFfeoS/gXDxrdIBV/aysLn4x6iH1mHim3VuFnAIkBi/FgmpCwV2n8mhAwodumB3PhVSPFQ/mA/zfsouDDkrPRYK5kQeumwSwTuUKjt8wGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSNDeI5T0bW+QT9Squnh8uc1NN7BxHMp0GMmhkoljfg=;
 b=x5pKIwTVP6f/1nylvG5pKKWP6sldO+6I7GSePMmTtyUZQQ3FFzNZP/dnvplPVDMgTAlpDxERzdUY4TUh5npnj7V/FAL5ZSgmFI+toxqFNWc7tOxkvSxvXN1+NMejY/rWBM5aNl9P+szFDc/e07/kSTmH7Bwgr9zMFvwsVHRPWb7+viXDfwk1nbfMcwEF1Mphb7KopfgRGPlnLfR0xhPS8tkq51Qm/qVwvqqiUh1s62TP8EU/JK91gxFRbWxpHOxQdrccm72Mt9Hq7IUYjW5VDi48+GdhK7mcz8s5k0syKkb/G4fsOpSsyHlZqSIyC+KMssV8M6MDCw5kzBwqYoiZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSNDeI5T0bW+QT9Squnh8uc1NN7BxHMp0GMmhkoljfg=;
 b=VX7SY373x0gBk+Hd9jPXvVzsK3ApIBIfPuTFxn0dEm7pEcgDzpgkRoX1k/+7KDKbmaMZ+7odPGxZng6rQAbaYPaGiBiq7zqM0w91QROeZvJmA7FujvcCvdJzSNsVAf5MimdAagLxMkPsvOMoJF0tZZMK7tR4Blsz8d7ZYN9/9ys1KapLOTS0ZmqSRjjxgFIopMv6bVLNRuYBauraBuukGKrHig+IARmQ1b7eXwwE/UE91mlHqV593MrZP9XZPxgyrttE+AIHQ2xyNoRUtJNEvyc8wgbjurYBRcpSipXL9u8gp45FQzKPqZs9ZFWnzgcaPQmTpsNCjGi4AekxxL6h7A==
Received: from TY7PR01MB804852.jpnprd01.prod.outlook.com
 (2603:1096:403:403::19) by TYWPR01MB10742.jpnprd01.prod.outlook.com
 (2603:1096:400:2a6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:39:04 +0000
Received: from TY7PR01MB804852.jpnprd01.prod.outlook.com
 ([fe80::4c0d:ea93:5322:ee61]) by TY7PR01MB804852.jpnprd01.prod.outlook.com
 ([fe80::4c0d:ea93:5322:ee61%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 14:39:04 +0000
Message-ID: <TY7PR01MB804852139F8DE700384359B59489712@TY7PR01MB804852.jpnprd01.prod.outlook.com>
Date: Wed, 11 Nov 2026 22:39:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: radeonfb: reject a zero pixclock in
 radeonfb_check_var()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, byu@xidian.edu.cn,
 25181214217@stu.xidian.edu.cn
References: <20261101104107.33909-1-jq.zou@outlook.com>
From: Jianqiang Zou <jq.zou@outlook.com>
In-Reply-To: <20261101104107.33909-1-jq.zou@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0113.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::14) To TY7PR01MB804852.jpnprd01.prod.outlook.com
 (2603:1096:403:403::19)
X-Microsoft-Original-Message-ID: <7e4a88b6-9e90-408f-807b-af300a2958fb@outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7PR01MB804852:EE_|TYWPR01MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: b26fb997-f444-4495-e67e-08df40018790
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|24021099003|25010399006|8022599003|41001999006|23021999003|6090799003|8060799015|12121999013|15080799012|19110799012|5072599009|3071699003|3412199025|440099028|26104999009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVpRVVY2YlR6alljWHJYekVHK2FvZ21KNjVETWQrSXhkL2dxdWxRMXpZQmpK?=
 =?utf-8?B?ak5jMFhQNjFTV0kvRXBENnhtVFZzcXY4ZXpqR01maC82SldSV3hueVE4RWIr?=
 =?utf-8?B?c0NlVTdOcnNYaXpHYndGeUFtYng3Q3dSdGF0bGZPSXg4emxmUUt4WERFYXk1?=
 =?utf-8?B?a0U5Zi9SNWVjcGNaQ1gyQ1RVNGxidkJ1T3I2MXErSU1WbE1Ub1NleVRlLzdq?=
 =?utf-8?B?SnBjWTVDcWdJWmpmWnhxRnBFU1RsOWE0dERXMFo2REFDOGg1WHppQ1lwYnVT?=
 =?utf-8?B?dndZZW5JMEpmeHZsK1BNbHNNWXI2Tm5BUGZqTS9nODBJTnlzZlA3OFhwYTI3?=
 =?utf-8?B?US9zQnFHQk96VWVyZWtSd01VZVZ0VkYyQlM0UXlmeVdXWmsvQTQwQTVSWTlO?=
 =?utf-8?B?MFdCbW5uUnZuOEhYRFNNbGRRMEZBUURSSmI1UkpwclUxaGI2TEhKUkJ1UmVN?=
 =?utf-8?B?SmZJRmRRdWpoeXdkOS9Ia2pya2JNMmJ4aElhTnJpVnF4KzRGek1jNXhkMXpx?=
 =?utf-8?B?bmVGMXh4TzFQT3dCZXgxM1BRRnhKTFhJMTlXdEU3aFZVNlBkTlRIWEM1N3BZ?=
 =?utf-8?B?VzdsbDQwL2g1N0MxT1JlcjdJNWVueTJQQUphaklpcDYzNXFPdEVYRUU2ZkFJ?=
 =?utf-8?B?Nk1CMklRREdzdVAxK0Y5ek5JRHJObmJHdDZlaDdhdUhwSzdiS2kyUnRoYUV3?=
 =?utf-8?B?OTlQUEFWQ2xVdXcwV3lub3ZrMkxlRkJuazJWUzRIbWY3WmZpbVlVOHprVGRS?=
 =?utf-8?B?TUpyb2RxTXlYdHJzTXN3ZEppcDMvaytzYlpmNWhxNU5OZDc2UHhmWUt2Yjdh?=
 =?utf-8?B?TEdOa3draWpJZmpvek5ZNnFicForTHhnV1ZCODFNcHVwYVg2azhsQ3ZwWmxa?=
 =?utf-8?B?TWR1Mmg5RGllbUlZYmh4SEo2Nk94S2Q1TEpXVG1UMUZvaU5rSTJQVmJXNDAr?=
 =?utf-8?B?SjV0S1o0UTJDZjhlZGpLMmtiZU9Dd3ZMRjJwd0szampGUzh3RnE5bnl3SGF1?=
 =?utf-8?B?aTB6M3c3eWZ0NnZPMjNKTFQ2b2VyaVNPY0FqNzFnU1ZZODAwOGNMMUN1c1Vk?=
 =?utf-8?B?cE9sWG8yWnFyWEU5bjdYUnNTL0FGaTd4bjlqTEJ3ZHovYzg0QjBkZ00xZzk4?=
 =?utf-8?B?MzRHOWJyMWo1WGlia3hLN0ZWNEVjT1MwZjBCUnlYQ3laaEhkbTNKNWxpOGRC?=
 =?utf-8?B?VTVYMC9GbEE0SWdpVEVIY2taZUYyMThYMm1CL3lXQWlIcTRFbEhjaEx5KzdQ?=
 =?utf-8?B?a3E3am16QktXNGZockZvd05IUlAwbE12bEVzRXJkcW5MMnZSMStKWE9rQlJL?=
 =?utf-8?B?SUpEWSt4VTh5N3NLVWRuVzlaVEtLa1ZJWU1nQzFSK0dlVmRnSWFpeWlHUUVH?=
 =?utf-8?B?MGthZDRCdkI1SWc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdrVmQ4U2dJbnFyWnRUdGFkVGVZOGRGL1pmaFR1YUpRbFZVR0JuSDRGN3FO?=
 =?utf-8?B?eHBEMjVGN3IzZndjSGVSL3E1S0VZTWN3VXRQdnlCcGZOcDEwVzlrcExqV3Q3?=
 =?utf-8?B?OC9iTWFoTXhoaC9GTkpEQkMxRjl4NWRUbGl4SUkrOTdGMHlXNjBvS0lHNm9p?=
 =?utf-8?B?Z3plb1ZXQTkzaS9UN3hlckNHSk9mU0lUUzJNL21nK3M1RExnTE16d1hGSDY5?=
 =?utf-8?B?c21HeWVXMFVtcDVYM3FURlQ2QzB0WlVlRDRJRkxIeDUyK29MaHZGN0ZVcWlt?=
 =?utf-8?B?eVhsY3pPOGxNZlZqUkVBNUtZeG4zQmsxV1hIajg2SnRRaWZaSnVrTG1jM2lm?=
 =?utf-8?B?NDlQTVExSlRwVVEzZHAwbXRMYURmQTJyUFBya3J0SnBjQUQ1NWFVR2w0NFY4?=
 =?utf-8?B?TFpha0xJeTF0UUIwemt4aEVQVUlvaGtJMDNhSW4xWXlpazJnQy9LNk5mUG1J?=
 =?utf-8?B?YldTdDJOTnhyVzNuOXl6dEY2dHpac2dtdFc2RTVYU05taW1Zd2JmK3dXcFhj?=
 =?utf-8?B?Uk1kaUJmeGpoY1cvSVhpWlc4UEJaV3ErRTF2U0dpNXNpdGxmM2pMVUpxT0lN?=
 =?utf-8?B?SEZkRnFJeDNITzZkREQ1cXE5RjdTYkFkM3gzVUNzTWt3Zm83ZEd2Wnc4OUpF?=
 =?utf-8?B?N1dDQW5WUk1KYlZuUG1zellQR2lzdGdzdWovYU5ydDdPelhPWVVnL0w2U0Jq?=
 =?utf-8?B?akU1ck1FamNDNFF4MHJDS3BxNmYyTnEwUG1lNk5NUFpVMzRjdUVVTnF6MjdT?=
 =?utf-8?B?OW40TkxZVWRpTytTMWYxci9sU0NWQnpzR3AxbEVYb29SYkw5QVJsaythODda?=
 =?utf-8?B?SkFNeHZzSmxyZ2VVQ0Qxc29zT2MzQ1VDZ2hub1ZWOWJaT0FXMGFVVEl1SVFE?=
 =?utf-8?B?REh4NDBoZ2MremcwSUY3VmNxQjQzR3NxVWFwWUhISDJlWUVaVFlhKzBvbnRS?=
 =?utf-8?B?czRka21sd05RakJPWWpweDFOWW15Q3A1UjJqemNkSklEa0RHMVU3ZC8xWmlJ?=
 =?utf-8?B?VFZvM2E0VDYyTWNUVlBqRG1rMGlkZXNJNzZGM3NzaHMvWEN4SlFYSG5STmJt?=
 =?utf-8?B?UVNWTGplbStSZ1lvVjRVZzJNWHNTNGZ1djQzMU5VMGgrd20rM20vOE9JL3ZW?=
 =?utf-8?B?NURmeVBVUUhIV3lmenN6NmdXdGltR0J5QWpKNkc1dk5pV3Bybm9oZ1BuV1Bv?=
 =?utf-8?B?YmJ5YmZGZlJ3b2tqb1k1eDFZeFZoYnAxU0hLdElSZlVKR0pRV0NISXBkQXJH?=
 =?utf-8?B?TEkwcnc0QTBrL0FjL1VhK1NKTStrc01CaWZKQ0RlYnoreWdFbVk3SmxjbDNj?=
 =?utf-8?B?aGR3Ymx3M0tnV000NVplUFk5cWdRMjRTT3dRbnNYU2E2TSt3WCtDbzVjU0Rk?=
 =?utf-8?B?V1BVZlcrNnVvSmF3a1RaN3g4M3VHTGpNRW1YNFVTVFd6Qm5TM3I0OVRlV3pl?=
 =?utf-8?B?QTVlN0RRVzZRd2JRNkRBaUJaMVlUOEZObWo4RHZldFZPY3NoUlkxMVowL1FD?=
 =?utf-8?B?WGV6dkhwNTJkK282eTBZcjIyWC9aQU14SFpDREhkSFpIQVhiOUd4UXhXUys3?=
 =?utf-8?B?cjhpengvT25CbUxlYzBsbDluUXVjSFIrTStyaENGYkVMYkVUeXlETWNJSWYy?=
 =?utf-8?B?RWhPZnpkQVFvL0FJb2lMWlBCN1lUaXppU3kyQ1E0VzVKbzZZWkhrRU9VMk1I?=
 =?utf-8?B?TkkrMXhtcmhEM0l1cGxPeGtKNTBRNkd3R1l3eStEUU5ZeEhkajJmUTBsc3lz?=
 =?utf-8?B?UDlXR2RCWnR3OU45NE96MWpLY3lhSm5SSTJ2TlV5Y0svcU1XSitVQStLaUFy?=
 =?utf-8?B?NVN0NXhvVjVpbkd2cmFESDNQNm8rRG1QVjhpZGxrTkdxY2ZjeFhnMGEzWDZh?=
 =?utf-8?Q?IEuCB7OBUC7kZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26fb997-f444-4495-e67e-08df40018790
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB804852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:39:03.5955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10742
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On November 1, 2026 at 18:40, Jianqiang Zou wrote:
> From: Jianqiang Zou <jq.zou@outlook.com>
> 
> radeonfb_set_par() derives the dot clock from the user supplied
> struct fb_var_screeninfo:
> 
> 	dotClock = 1000000000 / pixClock;
> 
> where pixClock is copied from mode->pixclock.  A zero pixclock
> bypasses the existing validation and makes the kernel divide by zero
> in radeonfb_set_par().
> 
> The driver does have a check for this: fb_validate_mode() returns
> -EINVAL when pixclock is 0, but radeon_match_mode() only calls it when
> the output has no scaler and an EDID-derived mode database is
> available:
> 
> 	if (has_rmx == 0 && rinfo->mon1_modedb)
> 		if (fb_validate_mode(...))
> 			return -EINVAL;
> 
> mon1_modedb is only filled in when an EDID is read, so when no
> EDID-derived mode database is available the validation is skipped and
> the invalid mode reaches radeonfb_set_par().
> 
> Reject a zero pixclock in radeonfb_check_var() before matching the
> mode.  fb_set_var() calls it on the FBIOPUT_VSCREENINFO path before
> ->fb_set_par(), so the invalid value is rejected before the mode is
> applied.  This is the same check other fbdev drivers use (i740fb,
> arkfb, s3fb).
> 
> Reproduced on Linux 7.3.0 using a custom QEMU PCI stub device with
> vendor/device ID 1002:5955; no physical Radeon hardware was used.  A
> single FBIOPUT_VSCREENINFO with pixclock = 0 is enough to trigger the
> divide error.
> 
> Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>
> ---
>   drivers/video/fbdev/aty/radeon_base.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index b6b058cee..a69e58914 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -836,6 +836,9 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
>           int nom, den;
>   	unsigned int pitch;
>   
> +	if (!var->pixclock)
> +		return -EINVAL;
> +
>   	if (radeon_match_mode(rinfo, &v, var))
>   		return -EINVAL;
>   

Hi Benjamin and Helge,

I'm following up on the radeonfb patch I sent on November 1. It rejects 
a zero pixclock in radeonfb_check_var() to prevent a divide-by-zero in 
radeonfb_set_par().

Could you review the patch when you have a chance and apply it if it 
looks good? If any changes or additional testing would help, please let 
me know.

Thanks,
Jianqiang
