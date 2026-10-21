Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E7606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelburch.net header.i=@michaelburch.net header.a=rsa-sha256 header.s=selector1 header.b=kJ2Oqw5L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E1C0112448;
	Thu, 22 Oct 2026 09:41:17 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11022105.outbound.protection.outlook.com [52.101.48.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A6C10F9B5;
 Wed, 21 Oct 2026 13:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOSWjI4kEFBVyDwXZWacvXfQVplbntQ27YW4lnizmp7TUcbI9gLnu1CHQYC7iQwDUSKec/MkQgwiTJxkEmv6wDgWWg+nh6qwX2FrkXh8KaIFjZ4nnySVUtZe7c5o3Jw3dXps3z4JB1qPJ3ESfQ2XMeQVTpM9yBRQbVbNmz4QErWPN0NSjPGOKN1qOcr65oYrO4+XkZubmJvo+McanCNt1uaXPVEdQFBfT+ksNZ/ouOX8HXfIJuB5nvwdnlFmMgssVWITaRLM5YtaJoFbS/6xAs+4AK3O/1w48a7vwuQaA19IUmaYBgcxeIe8XvJa8ennvCGJht1FeWHmLQkoPFzzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdQZ54cHEoqXgd4hgXwDb8oJoZD57cxK9olpV2wM3/E=;
 b=c1uj0/qrGtqUvxXu0rlw3SYJk2PnbShdFKOfywRkvqYjGztVQV3G3DX2KtLfdgfgtHX+ctuHsriSsVQNMlv3rJsbwZrzBuOcp0qvrZ6azIX5Y9G20wRaXwCakM2PioOYr0loVNgVV4h/LS09CJWwH2c0G8fTGxlw4XcR3/DrBm5MnctwHoeU3RpRc1TRN6Qpb7WJHNzTwG955pJPc3GbKwqphNmsEdAhLiIDS9CE/Uku5GNVgrxM93LPHzGpYxkl1FBo/rvkKqrpDssb5qBZzThjYTqgVcKpb0VJ4qGqZZRwDV8jA7Qia51/Kd86iHAQ4zICA5LbfPK5Zo8pDkNk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=michaelburch.net; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdQZ54cHEoqXgd4hgXwDb8oJoZD57cxK9olpV2wM3/E=;
 b=kJ2Oqw5L43H8beuyTzqLjB1344o/F+tCBAcJrT6shnVwENlMpeuIxX97AkgAEQ99O/OLoNiKhY4WF2/63OGWAw9j2tKGxPTPL+bnXme8awV5CfWMDIE8cYspWGelPy6Y6faWiiU701YVFLw0vPivZPI+uTJrOY/GEj9DYmbJviEDXHf37ml0ppIbNQSnyk9K9LcGIco9BDpVO1FsU/9m58yozeRokkRt3+O9gNdxOgZVzYQrTpTTHGvNLTWAPkgghvLJq+fTQMVywJupjXYdz3qiQVE4EhO5TccH0flPmk/f50SjVEr54RQc7aQHxK3gBkhbInKoKM4GA7PqLs29sA==
Received: from PH7PR01MB8123.prod.exchangelabs.com (2603:10b6:510:2a4::19) by
 CY2PR01MB092432.prod.exchangelabs.com (2603:10b6:930:115::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.2; Wed, 21 Oct 2026 13:25:50 +0000
Received: from PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930]) by PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 13:25:50 +0000
From: Michael Burch <me@michaelburch.net>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>
CC: Shivam Rawat <shivrawa@qti.qualcomm.com>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno: Leave the GPU RSC awake for system
 poweroff
Thread-Topic: [PATCH] drm/msm/adreno: Leave the GPU RSC awake for system
 poweroff
Thread-Index: AQHdU25XWw1ewLLIzUiovze0ILwUkLcIBCEAgAAUFI4=
Date: Wed, 21 Oct 2026 13:25:50 +0000
Message-ID: <PH7PR01MB8123B555D5C4DD0E8853F903A5662@PH7PR01MB8123.prod.exchangelabs.com>
References: <20261003193518.13811-1-me@michaelburch.net>
 <70c9b4de-6403-46ba-a125-9e792d4f63c8@oss.qualcomm.com>
In-Reply-To: <70c9b4de-6403-46ba-a125-9e792d4f63c8@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR01MB8123:EE_|CY2PR01MB092432:EE_
x-ms-office365-filtering-correlation-id: b65348ea-a12c-4e3c-67ec-08df2f76d333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|10067099003|8096899003|13003099007|4143699003|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: ZegvkYn7MmKpfYiOXEdI3PYtLwM+HLHzKFX3StvdiLHpFTP6M29qbQHXGTLkBiruTOX1igbdFeRUfpf6C9wQs9T4NfwvZLETf1IXvrM8MkWEEkBkXQ+897wzmF4Tf7aECXPsRXif7S57sDc8XsepG3LDrPuWzrtbSRALvwDPh8152o7Q0YaJs2VboV7h5qCvhaCJsFUjmHxOhUuMCKAjj/eqX7VQ01W5tdRI8Gdb91ZezGw+nAthcCux0L1MqGyHDDF/bGH9ItC3CVM9K1w4d/zX1ZCEExB00M9clhwPq2KRG5LrL2ynx5w7NdnYvOkcx/7geOmBPaDC+OaOAGJ4Hl0AdaF94Pee1DN5xuKykuYyIimEz9VUYHv8Kx5r0pmb6ayZgdIZ9oORbA0v06Z+mFZAAdmf6BCRGYwoMXp5pfnPRRxLoJ4t7oyxtujkmwjqJpRElRjbp6Cp/sv+bLAS3gahhf9yixMYdy+ciJFM9bjSS61UKCDuOP13g3So+TrVe52/WzpQOGNIXeaYzv5ePhnu97KEPSfug1VUsunwWcay7HRN+EHc42EJWAgK0n4qYw7KbrXeghj8Z9grq2UWNOrw2axCy6ZdfOHZ1KLL0hbZsZi4rUMjD6fRpdFRRRUK/lpM/LWuTyNaK1X3tUA6z+sJWw9NRXxHt/widSgSdF8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR01MB8123.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(8096899003)(13003099007)(4143699003)(261009223027099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RJaKi9+Rlt9GsT050oEPcvyh2LQRpWtoHkMfnCk/bBoCtZKAYnbCS6Rukvxm?=
 =?us-ascii?Q?HZBbI8c50yFop8nQqPUg+M1HPuCyU9Tqzdx8C7WCnyTyyYhDPaPu5cwv02bi?=
 =?us-ascii?Q?XJqJnoZsGzYfxv5Sq9+DXFMWGUDCyeLi4W06jsCHGMkmZ/kKQOy+oY/l1gla?=
 =?us-ascii?Q?XCfSSBLzOIR4BGV6ZFW+ym4LE6puUkVbOSz7Rc3GH/LdVWacYHsl2pIj1PKH?=
 =?us-ascii?Q?RiFUt12cD7DOnpaBcmd9w+oqpZVvQliL4FzoB8g09cwu6GzTkzXkeIjSIcpg?=
 =?us-ascii?Q?ZiLs43mnbvjbx6YX8Y3Qu7Xh12gaUuijBUmGfBejrDoqiycQRQBzdvC9eRpv?=
 =?us-ascii?Q?fi/gxwHJcORULlT+LUR9K9y00KBkHbUDWjdcXqt/TsE3KHFty2HkzhjyElzR?=
 =?us-ascii?Q?R7u8GajzBuLeX88jEKZX3MkSdRdJ9+Y54Smk/TpQujiSDEyslDn1mGBBYkgX?=
 =?us-ascii?Q?flRHVnmEdDDGpXFGJESwH8Ao854zE8oEa/aGl/OSlUNoRjPgaH42TTctauY+?=
 =?us-ascii?Q?XcuUh1CqegAii5+PmJXo8nir2N8+Ows8FRW/xqqbCm9KgOjlWnTli+AcSiqY?=
 =?us-ascii?Q?hnrVZFsbKhtNbLAgBWTdICADehWO4Yd27Nzqe8/dMNcl12nQ0pIebjmK6ftK?=
 =?us-ascii?Q?ldTVXcOe4Te1bXBXhhBYFRku09ijKUBcOTjsV9A/B/ZXQxXF5+BJyNJW6ziy?=
 =?us-ascii?Q?DXq9wkaxwxGojx6x4IAyCSdBHs6fBsRxjr1sJ8qdKtBlmkYS5BhHKT/m4/6U?=
 =?us-ascii?Q?V1Pqw5Kp6ykGiYfQ5ybQKplQWaqrbwKOmIzOWXES/OXF+8SCOwUB5DEd5Z9u?=
 =?us-ascii?Q?JjZBYWuLn08faxYgh9ulkMtnP9L8emE3LUamoxxKDGcu5UlLz7brnFQFliXW?=
 =?us-ascii?Q?2R5frr5bWt80TdePRqR+M8zIiU0b05cIynDHqm6RhBsOAGcj3RiZ4PcTxoZD?=
 =?us-ascii?Q?usCmdnaJacYOAtHqAuEw9+3QZPf3YTOsmKn+tdO7F2yutSV+G8fYohW1u6+w?=
 =?us-ascii?Q?16LVO+gRC41WP7Gf7TuyxE1/u+WT0PRo7S1vW+COmxt7GAkRk/rM8dKbFkTU?=
 =?us-ascii?Q?CCImX8c9gWFC3T7bzA+5pHhJOGvgKLamid2oq3bJXgF7kHztDhVJSol4MtWU?=
 =?us-ascii?Q?jqYvAKfO1cZTANTEDPaM2SwmLU/2FIYbDCXThodw+nAtfzfqzTFmz314YwSt?=
 =?us-ascii?Q?cpodX5RZf+uj363hYBszpFusAgQ0oX4t99SvNwJDVYR5pBvdOHMXfkH2soRb?=
 =?us-ascii?Q?3GMOT8gcFjQpwcua19Eql9w6tkU+fUhTV+EFeHwoQmPzTzVhGn/js5L8fH55?=
 =?us-ascii?Q?rJfN2mMQLxUj+Tn1e6Pkkq7ARp07MNdb6ULljb87YbHmEEUMrZdvgGQUwzhe?=
 =?us-ascii?Q?vCfoBpewNK/kYcvd0FKSvai9LvwlSQs3gUu1o6StCF84ZZ5Cy8MHqi/a9G2j?=
 =?us-ascii?Q?lAVPgkS8S9V08qlmQuNS1RIvQ4poKAn7hxdrQzAX9JGW3eR8qp89Rlo7ppGk?=
 =?us-ascii?Q?ONZF3Ap52J5qZarbviyUk089WolJ5R9vVb66bcEFyraaIgSPwm0sGRpCQGry?=
 =?us-ascii?Q?MeHpOuj+6fipYbe9dZxs8a4lzELzugE1Brl1QsuvYACgCIIvYMn7qsUvntN5?=
 =?us-ascii?Q?Tcx9dIDUMdRwACHqsMpZy8lF4vgngKDSyCiTAOsNSDLfs+FSQ3VU8XqRM8XZ?=
 =?us-ascii?Q?mPSf6SR4WduJZFOtTg3F2S0VsuqyiBEecqdQhN/lrtnLQeLk?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR01MB8123B555D5C4DD0E8853F903A5662PH7PR01MB8123prod_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8123.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65348ea-a12c-4e3c-67ec-08df2f76d333
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 13:25:50.5426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xGvEfQnARdw3mbHqQhfcGbesapOCfLC+cfVGU4EM9W+Vcl/ir325NFAj4rs9JRnJ9HWADEtUyXmOqzLxUti4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR01MB092432
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_PH7PR01MB8123B555D5C4DD0E8853F903A5662PH7PR01MB8123prod_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

No, testing included the sync state fix from here: https://lore.kernel.org/=
r/20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com

My mistake, belongs in a reply to that thread
________________________________
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Sent: Wednesday, October 21, 2026 7:12 AM
To: Michael Burch <me@michaelburch.net>; Rob Clark <robin.clark@oss.qualcom=
m.com>; Akhil P Oommen <akhilpo@oss.qualcomm.com>; Konrad Dybcio <konradybc=
io@kernel.org>; Dmitry Baryshkov <lumag@kernel.org>; Abhinav Kumar <abhinav=
.kumar@linux.dev>; Jessica Zhang <jesszhan0024@gmail.com>; Sean Paul <sean@=
poorly.run>; Marijn Suijten <marijn.suijten@somainline.org>
Cc: Shivam Rawat <shivrawa@qti.qualcomm.com>; linux-arm-msm@vger.kernel.org=
 <linux-arm-msm@vger.kernel.org>; dri-devel@lists.freedesktop.org <dri-deve=
l@lists.freedesktop.org>; freedreno@lists.freedesktop.org <freedreno@lists.=
freedesktop.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.or=
g>
Subject: Re: [PATCH] drm/msm/adreno: Leave the GPU RSC awake for system pow=
eroff

On 10/3/26 9:35 PM, Michael Burch wrote:
> On X1E80100 (Dell XPS 13 9345), commit d9108bfdb746 ("drm/msm/a6xx: Fix
> stale rpmh votes after suspend") appears to turn poweroff into a reboot.
> It seems to happen when the GPU RSC/PDC is asleep at system off, i.e.
> when the GPU was idle before shutdown. Keeping the GPU awake until
> shutdown avoids it.
>
> Resume the GPU in adreno_shutdown() and skip the RSC sleep in the final
> stop. Suspend and runtime suspend are unchanged.
>
> Tested on X1E80100 only: poweroff and reboot on AC and battery, and
> deep suspend still drops the GPU votes.
>
> Fixes: d9108bfdb746 ("drm/msm/a6xx: Fix stale rpmh votes after suspend")
> Signed-off-by: Michael Burch <me@michaelburch.net>
> ---

This is odd - did you test it precisely with and without this patch
and no other changes?

Konrad

--_000_PH7PR01MB8123B555D5C4DD0E8853F903A5662PH7PR01MB8123prod_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0); --darkreader-inline-color: var(--darkreader-text--darkC=
olor_rgb_0__0__0_, var(--darkreader-text-000000, #e8e6e3));" data-darkreade=
r-inline-color=3D"">
No, testing included the sync state fix from here: <a href=3D"https://lore.=
kernel.org/r/20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com=
">
https://lore.kernel.org/r/20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss=
.qualcomm.com</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0); --darkreader-inline-color: var(--darkreader-text--darkC=
olor_rgb_0__0__0_, var(--darkreader-text-000000, #e8e6e3));" data-darkreade=
r-inline-color=3D"">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0); --darkreader-inline-color: var(--darkreader-text--darkC=
olor_rgb_0__0__0_, var(--darkreader-text-000000, #e8e6e3));" data-darkreade=
r-inline-color=3D"">
My mistake, belongs in a reply to that thread</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Konrad Dybcio &lt;kon=
rad.dybcio@oss.qualcomm.com&gt;<br>
<b>Sent:</b> Wednesday, October 21, 2026 7:12 AM<br>
<b>To:</b> Michael Burch &lt;me@michaelburch.net&gt;; Rob Clark &lt;robin.c=
lark@oss.qualcomm.com&gt;; Akhil P Oommen &lt;akhilpo@oss.qualcomm.com&gt;;=
 Konrad Dybcio &lt;konradybcio@kernel.org&gt;; Dmitry Baryshkov &lt;lumag@k=
ernel.org&gt;; Abhinav Kumar &lt;abhinav.kumar@linux.dev&gt;; Jessica
 Zhang &lt;jesszhan0024@gmail.com&gt;; Sean Paul &lt;sean@poorly.run&gt;; M=
arijn Suijten &lt;marijn.suijten@somainline.org&gt;<br>
<b>Cc:</b> Shivam Rawat &lt;shivrawa@qti.qualcomm.com&gt;; linux-arm-msm@vg=
er.kernel.org &lt;linux-arm-msm@vger.kernel.org&gt;; dri-devel@lists.freede=
sktop.org &lt;dri-devel@lists.freedesktop.org&gt;; freedreno@lists.freedesk=
top.org &lt;freedreno@lists.freedesktop.org&gt;; linux-kernel@vger.kernel.o=
rg
 &lt;linux-kernel@vger.kernel.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/msm/adreno: Leave the GPU RSC awake for sys=
tem poweroff</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 10/3/26 9:35 PM, Michael Burch wrote:<br>
&gt; On X1E80100 (Dell XPS 13 9345), commit d9108bfdb746 (&quot;drm/msm/a6x=
x: Fix<br>
&gt; stale rpmh votes after suspend&quot;) appears to turn poweroff into a =
reboot.<br>
&gt; It seems to happen when the GPU RSC/PDC is asleep at system off, i.e.<=
br>
&gt; when the GPU was idle before shutdown. Keeping the GPU awake until<br>
&gt; shutdown avoids it.<br>
&gt; <br>
&gt; Resume the GPU in adreno_shutdown() and skip the RSC sleep in the fina=
l<br>
&gt; stop. Suspend and runtime suspend are unchanged.<br>
&gt; <br>
&gt; Tested on X1E80100 only: poweroff and reboot on AC and battery, and<br=
>
&gt; deep suspend still drops the GPU votes.<br>
&gt; <br>
&gt; Fixes: d9108bfdb746 (&quot;drm/msm/a6xx: Fix stale rpmh votes after su=
spend&quot;)<br>
&gt; Signed-off-by: Michael Burch &lt;me@michaelburch.net&gt;<br>
&gt; ---<br>
<br>
This is odd - did you test it precisely with and without this patch<br>
and no other changes?<br>
<br>
Konrad<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH7PR01MB8123B555D5C4DD0E8853F903A5662PH7PR01MB8123prod_--
