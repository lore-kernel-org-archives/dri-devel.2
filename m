Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C446EC44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8341E10F7C5;
	Fri, 10 Jul 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="lq+WU5JR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazolkn19012055.outbound.protection.outlook.com
 [52.103.20.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC4410E256
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 20:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0c/XBq0ePPuZCYUjKAjWHT2yJnTuiv9B0rG+ZOK8sMDvmwUBCCMhnKAgi0o/NzpLNcQljTAlXjxhnEofm4WntMxgouQCYge6O4rWOW4fRfYvO+TO2d/NTNo4f7apcvcP6nJgMOw0RfjBksSytmB9Vq6l1joSaqcU7QMmzgaBSyc0IEQP4NQjzMzyMtjWr3hfx+DW5B6kpwsR2hojZYkXxhHqHBZFVFIs8ZWsfrH1g7KJOx+kZFsSMMGccJ/rSo6tEq3Hmx+EEd3ZZTXmnzocUMmpIA8215Us1BA9jPP+QF2x77xBEcbsl8nEf6GsN4AsFq95apqHCQ0QkedkGkJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xQTidVQ4Gw8+7ENU/+AxQQiEJgv82WKbLmwBFixWbg=;
 b=H8e2ja+YZKYLDOULbq+BoapXiEBckVw6muw1DqTQJycgsW1Cy1hV365M5dA5cOTVGQnq5dM85qk3hGGjp+xY5odhBHA1XzgiGiTVPFt2TIqDK8apfynLv3YhZJTHhk3gW1Zw2H4gQGZxkto0cZyBdXR5HpnvcRA9+ERs0mWVAl2MVJqwuQd738uLoR7k/qaWGKLQbRCHKba1vbS0G/BYoU4+v4A5AYwk4Xz0OMF0ajDg1LCaQGQxQ3MSpDQO/UDno/O+ZDsEmbJwfPIsSJqPN4vAdC87OaHnsCo5PEY5iYfVYSe8a3dTQw97608+bBkny1sw+g28sJyV7+AEcG7e3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xQTidVQ4Gw8+7ENU/+AxQQiEJgv82WKbLmwBFixWbg=;
 b=lq+WU5JR3bdr2MNxNB5fpVT4nrW0XhgcKpJqXQrKlBaw/m/Gh7e/iXCXA4QviV3dyrLUh733iHGCN6kfkYGVyxkauY4z/570YULzPOQy5RnNzj4LS/suzE6l44U9eE/t9DoZrlTlfbcK5EHeseMVduX3fcsiF6HsTMfosWCwwAlpcQKKDyaxXFMSd8/6MZGdqAqzFPwaBJJHU7uPMk0JHh8hPbLEoeJQ15Oqcy9AnyqWF8xosya9kimw8MqsnalBbMNu9tIUuI+56bEWHeIL2u8DuTRx979CdpTx6wYUW0mvUnHF7CgBz8ztPrPDZt8oyTthyq2MTRzjBgBa6DBX+w==
Received: from CPUPR80MB7117.lamprd80.prod.outlook.com (2603:10d6:103:1fa::15)
 by CPWPR80MB7894.lamprd80.prod.outlook.com (2603:10d6:103:254::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 20:28:51 +0000
Received: from CPUPR80MB7117.lamprd80.prod.outlook.com
 ([fe80::6cf2:e42b:8505:151e]) by CPUPR80MB7117.lamprd80.prod.outlook.com
 ([fe80::6cf2:e42b:8505:151e%6]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 20:28:51 +0000
From: Fernando Gomes <fernando.mgomes@outlook.com>
To: "security@kernel.org" <security@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: [SECURITY] drm/vmwgfx: Integer overflow in cur_bo_offset accumulation
 in vmw_surface_define_ioctl()
Thread-Topic: [SECURITY] drm/vmwgfx: Integer overflow in cur_bo_offset
 accumulation in vmw_surface_define_ioctl()
Thread-Index: AQHdD+E2Aexe86SdkUiynu8xinyZmQ==
Date: Thu, 9 Jul 2026 20:28:51 +0000
Message-ID: <CPUPR80MB71175698C08752E477347EB1F7FE2@CPUPR80MB7117.lamprd80.prod.outlook.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPUPR80MB7117:EE_|CPWPR80MB7894:EE_
x-ms-office365-filtering-correlation-id: 56f6dcff-b4a9-42c9-443a-08deddf8b076
x-ms-exchange-slblob-mailprops: znQPCv1HvwUXBahuwteIkQeW30lJPuxO6s9gXAhKxryy15Uxr4EbO7JyXB0f/TW0p6qpP+OIm3KQ2mQqxkTa1kV3ZGquZLQrRQ0+HJgCbQYUWNiHNZT4R2u5tSgZLlH4HXuVmS0nwKVURuIzdYGiymVT7h81PYbxGJNDi3KWNzzGJy31VZZhv7X/Lcu8TlSApQ0VH7x51fzyLpw5IUaFnylSPIR+wWE2iXmqYlK82AC+JgDFy9u4r7HOf3xOk2CcxWoajFv40dnp7TZDKe4+AMl7b5RlCAZUWE1k4c+UC4lBgwdQY+uGC0Dbye1lUFtnf+KsFWaP9vl0q0OqC8T/6cLMkcvZ6Eg7sqci02cGXvF1AYZY2VrzjcVHzghfHjktaf9you0EbSIhLVfEb0EKufaC9LByKSSamrh/BG38b/P8YK0VvYmsUDzvZU/LwLwmQ6ndNx2XUP9fV+L8HBG1qtX9Y/zUUMjRK2+RRk90IvAa6ZBAz4rng+8pPCMBBJOzXTfsdpoCYxr2Kpr7A/p6t7OT/zuPuXl7G677Vc7MPs0fgi0hUWSlc9yaKR8MZClBiP07BjPRB5u7KPWoEFmalGMENjPKcbDvZiIbcthy1K1EqlsmVmu3/sK2QHt2bmHYJlNH2mHQDpkqZjxGF+T/g4tomk43TLO9J0qSy8w0YXDd0xmIb/ZeijsasE0BWcBubKN2BxC7CMg7HiWg6shi+mDM1QxGMECoFA6Y1krAvtoQ29m1ijyHFKuI3VWwWwOZOfIBvZjXUUU=
x-microsoft-antispam: BCL:0;
 ARA:14566002|6092099016|25010399006|21061999006|4140399003|24021099003|15030799006|20031999006|12121999013|31061999003|8060799015|19110799012|15080799012|39105399006|8062599012|3412199025|102099032|440099028|40105399003;
x-microsoft-antispam-message-info: =?Windows-1252?Q?GPFtR4VjwYfs+Ta2TOGnQJdphrV6E8JKtV9tUXDcEiGV7dPreeIpDns3?=
 =?Windows-1252?Q?GAizRuzWtPw5QnBLWrvOsJS8W375U9O3IJP7ZN9sWmUs4Lv2VxEZGQ9m?=
 =?Windows-1252?Q?TBymxPNfEdRJyqNH8T3pGxi5qFawIzO8qs1bPi9xhe4qe5q4YDToxnbp?=
 =?Windows-1252?Q?+FZLoLO9qNLE6fVwzknY33nfo+z3SNIyAoxvoYhO8hp3beyTTNK39qIu?=
 =?Windows-1252?Q?etsfaV1I2v/MiLc6ctWdUan+ITa5+BnfFyWcTd7XPdG0hIWH1RCZUnHQ?=
 =?Windows-1252?Q?XmmSneyY6q7Qmhvj0pCPaI/yH+7Bz3/SBlBNctM6n7WmFpTDYIHTd9nl?=
 =?Windows-1252?Q?p2BwN58KSCvvPNtgnOGAAUREUsGHIqwqnWzVSccnhZLrToZIh+zzE1d/?=
 =?Windows-1252?Q?frgwVTExxfAleBStOTkvrc0ToqsmQwxIByhpVTc8Zy9DBZrFioTxMGeP?=
 =?Windows-1252?Q?cuRLleABcobL9KlLZzdMiXCiPA6gdvLG0/s4I9e7ZoDDY3WH4FGlad99?=
 =?Windows-1252?Q?70zBo7FttcHldsNRJjIDXwo01YNZSzTgdWEj4CfmhXmCNhUQSi4KUBD1?=
 =?Windows-1252?Q?3M93+wftMOxu01AxV4Xke1ZcUnLhL/c5KPe4kwViOR6/xi2WOW/WLVc8?=
 =?Windows-1252?Q?6wmkSFvGBRSItAFcRaHz8XS/UC0bRlXqmsADaCpWdKwLYE1TdC/bRJe6?=
 =?Windows-1252?Q?MzIXeuD06oDTUJfNX6qmdQRcOCrLBQQ+KB3o4ETDR4AYap80g2UX1XtD?=
 =?Windows-1252?Q?gIj4Rrjrd8yoegb6KgAdwbyJAsHPeIJWv/PDrG3FGTnB9mq50z8RR4hj?=
 =?Windows-1252?Q?QJ8FZSDZyqFESwWUgAtf1BYY6Co1n1qlgJA4/m9Puth2Fn+xu3z4OaPm?=
 =?Windows-1252?Q?ExxPBnctujTXL9zw44dxslszT3P0EH80kvEF1m3LRMYB4hqv7kXyagnZ?=
 =?Windows-1252?Q?cvckhbSCJ8l/GHx9rRDwRiwdR9QSAIMMEMHlPDaucfR9IqU77+Gu7g9c?=
 =?Windows-1252?Q?UyF0RmneLjO5+DdLhYTdocv7/YxW4ZcQW8WYWBiQsX4WuxJ9sB3GFDTl?=
 =?Windows-1252?Q?rEhqhqK+J0bXW0DO16+8dyAZ2lp7pKcRQWxBtDZX353IqI8VR9i9ypPC?=
 =?Windows-1252?Q?crU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Jgt2G2W/3NAyG2cUZQh6rtqYspbWtSALdMKPQsom4gd35xqPFZscSWSC?=
 =?Windows-1252?Q?yMU1+qaNoAySrNufsqn8S1Q9MbS0CQLKJ5pYDak4nYwzHNTdTkqv6y0J?=
 =?Windows-1252?Q?5TsIkaW8mwe8uugSSPpQX6hISJMq7HM6OeJlP8DRkn+ie8Wdfqf+kmqh?=
 =?Windows-1252?Q?yXuF0xdFi07CLgvjWg99VOL9EowO8P4WUSXdMAglcoEvFWoD3IW5UpRq?=
 =?Windows-1252?Q?YKTunC3eJtZgKhHkWKbzssStr0u1W6oBAZUnffIVojS+EEvbKGi7GJls?=
 =?Windows-1252?Q?IIv0kNacDZaHT4/XgmbX3rlIPWCjmi3FRjTf8SIQA4io2QwzPmpj3lRb?=
 =?Windows-1252?Q?406JCTfJalVJvAgSW9P5J6HwnsgP3f9GTLQF3VPNlHReNz5xkMpxh0Gv?=
 =?Windows-1252?Q?p+y6GuYS72P+GioVOpjSqK6BRBFG40Gl+JMvMlXCW+nNE1Z/a/fY+ZH6?=
 =?Windows-1252?Q?s2MV110OJGWWOGFW9Pn0EgR3H+X6hXkFA8+aVq/5UAtwtOZGP0EKLrQl?=
 =?Windows-1252?Q?syNP/647/OpKOvLiNisf0gWXQRxUw+/38d4dyZNf6irgrSfEgbgdvCWd?=
 =?Windows-1252?Q?zPz6ONgZblzDqrfP6jCtFsf/blosLtVAdTE9JfdZvjL5/inRmammuRar?=
 =?Windows-1252?Q?mp543CQ8wcSbnUFmjilmHycgdvGUjwQrt+jZesbg0xW2P6w5RexrmhZ8?=
 =?Windows-1252?Q?UjgQpT0A/U5JzGn93eeQvDDiZEAK7xiNQYbG5MAcI7/4Y8W1GyvgBXeC?=
 =?Windows-1252?Q?svgMLLjj4lF6szJPGRfKhyXPJ/WW/Laj5UQ7CyOftgR3ab5ZOl3gfAjP?=
 =?Windows-1252?Q?rQpi/DfIENaO78RMbWI9FEoOcqvjtBL0+fx0QKTWbvuHEVVCt7LZMIXJ?=
 =?Windows-1252?Q?0J/osXauFYzIkyagxBR3OnLMWqNycVB1DMPd4pl8qfcBqdrKkro5fJJU?=
 =?Windows-1252?Q?rgfvzW608X96otrRGyPOLyw4NLoGpw0dFe0b6/Hysr2tm9MLppssrzAx?=
 =?Windows-1252?Q?Y/vxJz2j7YcZv294Pup/rexcar+GMYxqiXXNVa9l2PNA3giC0chf0Dun?=
 =?Windows-1252?Q?zmAL7uuoCfH/rtmpQU/ZhaIfrQaZQBpPxGgzb6LYIgATL+Fcge+LyGir?=
 =?Windows-1252?Q?EuocebH26KiT+xUanDZ4JMenuWFxAX5MAA2zhHxuQcMWgsGOL10IIcRQ?=
 =?Windows-1252?Q?mLu1rwyLxYXCm2Xnla0Bf0FNTER+XEudk3al7Eu5U0ZtdI1SFynuuTwe?=
 =?Windows-1252?Q?sCnDqwqJs9nRwv7ulFgRuQWxuo6RgqdxWxpQK17pTQpAfUORrPhIVcdv?=
 =?Windows-1252?Q?xtjmbDfefmgm0SeVsLeDrB0H5yTBOAuDItbBeTFwM63875pEH7n2HG64?=
 =?Windows-1252?Q?Ee4NbU1pe5Dz5GbQcU9r5kPg7qde7OhV4RlX/u4Ke2pD8B0JCKJ9llGV?=
 =?Windows-1252?Q?HJxa63hJzHu6NGzZ6x1Iroz2joG7Ms9d3eT8UDh4f4NB3dh7VnOdKYMb?=
 =?Windows-1252?Q?ESGgcI5ilp6w80iD6a0kplGKhTCuQoGHvSYwfmvuOffoDAlnzG+mhHCZ?=
 =?Windows-1252?Q?z6Rfp22Vx7kpaF+k?=
Content-Type: multipart/mixed;
 boundary="_004_CPUPR80MB71175698C08752E477347EB1F7FE2CPUPR80MB7117lamp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPUPR80MB7117.lamprd80.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f6dcff-b4a9-42c9-443a-08deddf8b076
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 20:28:51.4816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPWPR80MB7894
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:06:09 +0000
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

--_004_CPUPR80MB71175698C08752E477347EB1F7FE2CPUPR80MB7117lamp_
Content-Type: multipart/alternative;
	boundary="_000_CPUPR80MB71175698C08752E477347EB1F7FE2CPUPR80MB7117lamp_"

--_000_CPUPR80MB71175698C08752E477347EB1F7FE2CPUPR80MB7117lamp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,
I am reporting a security vulnerability discovered during a kernel security=
 audit of Linux 7.0.12+kali-rt-amd64. This report is submitted under coordi=
nated disclosure.
Vulnerability Summary
An integer overflow exists in the cur_bo_offset accumulation loop inside vm=
w_surface_define_ioctl() in drivers/gpu/drm/vmwgfx/vmwgfx_surface.c, line 7=
94. The loop iterates up to 144 times (DRM_VMW_MAX_SURFACE_FACES =D7 DRM_VM=
W_MAX_MIP_LEVELS) accumulating per-mip-level buffer sizes into a uint32_t v=
ariable without any overflow check. The resulting wrapped value is then use=
d as guest_memory_size to allocate the backing buffer object (BO), creating=
 a severe size discrepancy between the allocated BO and the surface the GPU=
 expects to access.
Affected Component

  *   File: drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
  *   Function: vmw_surface_define_ioctl()
  *   Line: 794
  *   Kernel tested: Linux 7.0.12+kali-rt-amd64

Vulnerable Code
c

cur_bo_offset =3D 0;   /* uint32_t =97 no overflow protection */
for (i =3D 0; i < DRM_VMW_MAX_SURFACE_FACES; ++i) {
    for (j =3D 0; j < metadata->mip_levels[i]; ++j) {
        cur_offset->bo_offset =3D cur_bo_offset;
        cur_bo_offset +=3D vmw_surface_get_image_buffer_size(   /* line 794=
 */
                desc, cur_size, stride);   /* NO check_add_overflow() */
    }
}
res->guest_memory_size =3D cur_bo_offset;   /* stored wrapped value */

Proof of Concept
Using format 40 (SVGA3D_A16_B16_G16_R16, 8 bytes/pixel), width=3D8192, 6 fa=
ces and 24 mip levels:

  *   Real surface size (u64): 4,294,967,760 bytes (~4.29 GB)
  *   Wrapped guest_memory_size (u32): 464 bytes
  *   BO allocated: 464 bytes
  *   Surface SID returned by kernel: 53036 (no error returned)

When EXECBUF SURFACE_DMA is subsequently issued, the host attempts to const=
ruct a 3-level MOB page table for the 4.29 GB surface. This exceeds vmwgfx'=
s 2-level limit, triggering BUG_ON(mob->pt_level > 2) in vmwgfx_mob.c:518 a=
nd causing an immediate kernel panic from an unprivileged process in the vi=
deo group.
Impact

  *   Denial of Service (kernel panic) =97 confirmed on VMware Workstation =
Pro
  *   Potential out-of-bounds write in environments without the pt_level gu=
ard (e.g., ESXi/vSphere)
  *   Access vector: local user in the video group, no root privileges requ=
ired

Suggested Fix
c

u32 img_size =3D vmw_surface_get_image_buffer_size(desc, cur_size, stride);
if (check_add_overflow(cur_bo_offset, img_size, &cur_bo_offset)) {
    ret =3D -EINVAL;
    goto out_invalid_size;
}

Related CVEs

  *   CVE-2017-7294 =97 Prior integer overflow in the same function (vmw_su=
rface_define_ioctl), fixed in kernel 4.10.6. The current bug is a distinct =
variant in the accumulation path that was not addressed by that fix.
  *   CVE-2025-40277 =97 Recent integer overflow in vmw_cmd_check (vmwgfx).

Attachments

  *   poc_vmwgfx_bug6_final.c =97 self-contained PoC; compile with gcc -O0 =
-o poc poc_vmwgfx_bug6_final.c and run as a user in the video group.

I am available to provide additional technical details, logs, or testing as=
sistance. I request coordinated disclosure with a standard 90-day embargo.
Regards,
Fernando Maia and Renan Malafati
Security Researcher's


--_000_CPUPR80MB71175698C08752E477347EB1F7FE2CPUPR80MB7117lamp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
Hello,</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
I am reporting a security vulnerability discovered during a kernel security=
 audit of Linux 7.0.12+kali-rt-amd64. This report is submitted under coordi=
nated disclosure.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<b>Vulnerability Summary</b></div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
An integer overflow exists in the <code>cur_bo_offset</code>&nbsp;accumulat=
ion loop inside
<code>vmw_surface_define_ioctl()</code>&nbsp;in <code>drivers/gpu/drm/vmwgf=
x/vmwgfx_surface.c</code>, line 794. The loop iterates up to 144 times (DRM=
_VMW_MAX_SURFACE_FACES =D7 DRM_VMW_MAX_MIP_LEVELS) accumulating per-mip-lev=
el buffer sizes into a
<code>uint32_t</code>&nbsp;variable without any overflow check. The resulti=
ng wrapped value is then used as
<code>guest_memory_size</code>&nbsp;to allocate the backing buffer object (=
BO), creating a severe size discrepancy between the allocated BO and the su=
rface the GPU expects to access.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<b>Affected Component</b></div>
<ul>
<li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">
File: <code>drivers/gpu/drm/vmwgfx/vmwgfx_surface.c</code></li><li style=3D=
"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
Function: <code>vmw_surface_define_ioctl()</code></li><li style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>
Line: 794</li><li style=3D"font-family: Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">
Kernel tested: Linux 7.0.12+kali-rt-amd64</li></ul>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<b>Vulnerable Code</b></div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
c</div>
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><code style=3D"font-family: var(--font-mono);">cur_bo_offset =3D 0; &nbs=
p; /* uint32_t =97 no overflow protection */=0A=
for (i =3D 0; i &lt; DRM_VMW_MAX_SURFACE_FACES; ++i) {=0A=
 &nbsp; &nbsp;for (j =3D 0; j &lt; metadata-&gt;mip_levels[i]; ++j) {=0A=
 &nbsp; &nbsp; &nbsp; &nbsp;cur_offset-&gt;bo_offset =3D cur_bo_offset;=0A=
 &nbsp; &nbsp; &nbsp; &nbsp;cur_bo_offset +=3D vmw_surface_get_image_buffer=
_size( &nbsp; /* line 794 */=0A=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;desc, cur_size, str=
ide); &nbsp; /* NO check_add_overflow() */=0A=
 &nbsp; &nbsp;}=0A=
}=0A=
res-&gt;guest_memory_size =3D cur_bo_offset; &nbsp; /* stored wrapped value=
 */</code></div></pre>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<b>Proof of Concept</b></div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
Using format 40 (SVGA3D_A16_B16_G16_R16, 8 bytes/pixel), width=3D8192, 6 fa=
ces and 24 mip levels:</div>
<ul>
<li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">
Real surface size (u64): 4,294,967,760 bytes (~4.29 GB)</li><li style=3D"fo=
nt-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
Wrapped guest_memory_size (u32): 464 bytes</li><li style=3D"font-family: Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
BO allocated: 464 bytes</li><li style=3D"font-family: Calibri, Helvetica, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Surface SID returned by kernel: 53036 (no error returned)</li></ul>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
When EXECBUF SURFACE_DMA is subsequently issued, the host attempts to const=
ruct a 3-level MOB page table for the 4.29 GB surface. This exceeds vmwgfx'=
s 2-level limit, triggering
<code>BUG_ON(mob-&gt;pt_level &gt; 2)</code>&nbsp;in <code>vmwgfx_mob.c:518=
</code>&nbsp;and causing an immediate kernel panic from an unprivileged pro=
cess in the
<code>video</code>&nbsp;group.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<b>Impact</b></div>
<ul>
<li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">
Denial of Service (kernel panic) =97 confirmed on VMware Workstation Pro</l=
i><li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">
Potential out-of-bounds write in environments without the pt_level guard (e=
.g., ESXi/vSphere)</li><li style=3D"font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
Access vector: local user in the <code>video</code>&nbsp;group, no root pri=
vileges required</li></ul>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<b>Suggested Fix</b></div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
c</div>
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><code style=3D"font-family: var(--font-mono);">u32 img_size =3D vmw_surf=
ace_get_image_buffer_size(desc, cur_size, stride);=0A=
if (check_add_overflow(cur_bo_offset, img_size, &amp;cur_bo_offset)) {=0A=
 &nbsp; &nbsp;ret =3D -EINVAL;=0A=
 &nbsp; &nbsp;goto out_invalid_size;=0A=
}</code></div></pre>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<b>Related CVEs</b></div>
<ul>
<li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">
CVE-2017-7294 =97 Prior integer overflow in the same function (vmw_surface_=
define_ioctl), fixed in kernel 4.10.6. The current bug is a distinct varian=
t in the accumulation path that was not addressed by that fix.</li><li styl=
e=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: r=
gb(0, 0, 0);">
CVE-2025-40277 =97 Recent integer overflow in vmw_cmd_check (vmwgfx).</li><=
/ul>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<b>Attachments</b></div>
<ul>
<li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">
<code>poc_vmwgfx_bug6_final.c</code>&nbsp;=97 self-contained PoC; compile w=
ith <code>gcc -O0 -o poc poc_vmwgfx_bug6_final.c</code>&nbsp;and run as a u=
ser in the
<code>video</code>&nbsp;group.</li></ul>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
I am available to provide additional technical details, logs, or testing as=
sistance. I request coordinated disclosure with a standard 90-day embargo.<=
/div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
Regards,<br>
Fernando Maia and Renan Malafati<br>
Security Researcher's&nbsp;<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_CPUPR80MB71175698C08752E477347EB1F7FE2CPUPR80MB7117lamp_--

--_004_CPUPR80MB71175698C08752E477347EB1F7FE2CPUPR80MB7117lamp_
Content-Type: application/x-zip-compressed; name="poc_vmwgfx_bug6_final.zip"
Content-Description: poc_vmwgfx_bug6_final.zip
Content-Disposition: attachment; filename="poc_vmwgfx_bug6_final.zip";
	size=3016; creation-date="Thu, 09 Jul 2026 20:27:18 GMT";
	modification-date="Thu, 09 Jul 2026 20:27:54 GMT"
Content-Transfer-Encoding: base64

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

--_004_CPUPR80MB71175698C08752E477347EB1F7FE2CPUPR80MB7117lamp_--
