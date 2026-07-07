Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B720C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E2910F443;
	Thu,  9 Jul 2026 07:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rossvideo.com header.i=@rossvideo.com header.b="nNCGw6KZ";
	dkim-atps=neutral
X-Greylist: delayed 2112 seconds by postgrey-1.36 at gabe;
 Tue, 07 Jul 2026 17:08:10 UTC
Received: from outbound-ip26b.ess.barracuda.com
 (outbound-ip26b.ess.barracuda.com [209.222.82.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC5110E508
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:08:10 +0000 (UTC)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022096.outbound.protection.outlook.com
 [40.107.193.96]) by mx-outbound-ea41-75.us-east-2c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 07 Jul 2026 17:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWewwlsR7Ilwhnwh3ow98p0FGeuyg32NnGQPB5TZVg9Jd0YLiucYidXOflpN/aToMMjkGMwF6bn1yzBvw2KArn285CMJgUUsTLPlqCo6PxFFhUTAxns2cfDOnkn0DlRGthKUuWzKFtRHve4gaP2zR8aDB/Q/spEhXW0APAH3xTU5y/Sdu6o4F4AYK8j1HV7k8fb7vw8pBRasufMmWJqbYQPfemI+QNyzKT5AQiNmXReNz1TdIYnWJJR4vuBjhaNjuvITXbyLYKlsTVdjpu/FcpguMF+Ws1wYbR12/aiQZdRmAwhv5ZlslxYmrP+mKD34O78q/iZCKcBaYzQDjO4jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDP+afPg2PUjpzu9j89WgLO0qYJzdeUzXHsPtd9vEHM=;
 b=T1ttdNk8qaypHoBDgVNuFmoB+Up6ch9ngXYiAtW85ftyEvajsBq8m2lQEKejbSECVNuPlJM/eZNSAKbDgdRMvxXmI1rWFRf25y3VGup8nf2xstoVmWwC4pJaSsm/F0FVnRTsUpcvXO2Q0V+kE3OCj1DIpbp06gkLoX/uJUsogNA7K8RS6DdaQrQeK+uM0CrSYU+F8dalKLQU5vmV0x6/QJtvzDIiQaGs3HZxQ/fetJb2i10JxD2B4eQjG0HRjkQ87+im1VE8YnuBkXa3zccfOct4Elg2yeRW9h50g4RWT8LntavKthHmVtD/0Oph75hKWV6RVnigSwo4Ary4cP+zTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rossvideo.com; dmarc=pass action=none
 header.from=rossvideo.com; dkim=pass header.d=rossvideo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rossvideo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDP+afPg2PUjpzu9j89WgLO0qYJzdeUzXHsPtd9vEHM=;
 b=nNCGw6KZGocX8v+UMEwUSSQNfTC9Uvnqkyx9BJyQCB6iQMCDSz4UkZu/p3Io6CIkhacy7AlMJK3DmWdWBMP+DbHVn/RUxioVyL8hren7GdcV0NKfX1oCMauPFn5zBTMOzdISg1vR2eDSZEOlDIxpzyjS6XZG24AHAf7w4E54LK5txFAlneahqZHJgEAhCG5HUzWpjjpGpiUdu9BKtwL5TpiZ//PPs0NLFtmgJkPf3YHnLpqCiOuQIaI5sAuDK6CY2A7V1LrT21HVPb53+smpHpbevjhoWjOFzSEQEyLjg14COS+KUen+k8NJLoqu7Ew3MtMNG+ZEbozEybgZhY3x1w==
Received: from QB1PR01MB3907.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:3e::22)
 by TO1PPF55F13247B.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::646)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 16:32:51 +0000
Received: from QB1PR01MB3907.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3388:50d9:3310:1ac0]) by QB1PR01MB3907.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3388:50d9:3310:1ac0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 16:32:49 +0000
From: Itar Arneja <itar.arneja@rossvideo.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Michal Simek <michal.simek@amd.com>
Subject: zynqmp-dpsub: sample driver for PL live-video input on 6.12?
Thread-Topic: zynqmp-dpsub: sample driver for PL live-video input on 6.12?
Thread-Index: AQHdDi3ZWqN+DYCMEkWf8+ImxMkUfw==
Date: Tue, 7 Jul 2026 16:32:49 +0000
Message-ID: <QB1PR01MB3907C0D6FEDC794CC3514213EAF02@QB1PR01MB3907.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rossvideo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: QB1PR01MB3907:EE_|TO1PPF55F13247B:EE_
x-ms-office365-filtering-correlation-id: e5552c7c-cd92-4478-006b-08dedc4562a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|18002099003|6133799003|8096899003|38070700021;
x-microsoft-antispam-message-info: TzBM57uzPWrXe3cFUiTHr/30eXWL0Izg76uLbaEViICLKOKhtD2S4NBu981H1faKEveaEYzdLe2qXTj/pcMBR4sGEV/rXh538Gm6ItAh5mDwxuE3xZkouE03KdUC/7UliIMaQ/E3vA8t0XcBSBfNibrNX0O0EysSuLheAbKXBTBKGcZfw6bRs2Ld7Uk90lXYvmjKpMk2gEe9Ul2SpQ0td49nmkNjFtXQOPfShSmtliKd8eX+vjitBtnzKFE+vpkdh0GeHKoHEx81yMuic2WNKf92Uy2RhrQ2MZSyZlNJpz562txfG8SohjakS+yzidSAvqXS3EFmSVnys5h9d8EMco9psmO5jHpE+XtHDbn3IF6yNjT3veKZHef5N3LbTKk9e1+bAEhaY2XF8Vhku129DR4mAzpJUIsLBAa9Z1DNyl0YNoy5YdmRnxw6NzPraRrtVxLA+ZBP8sXW/ppoyuFgFkqJvUmSkFCAqjZ36q8j2HXKpMPqQRCopTbmACsZM1eoiWz6jNOdxEhyOjswblTraGVjphIE4Ep710iHZMpxxbn1GA2DrJpuOaVtSNajQ6FaZcF0bucI2EKkbup+2LLDjg78594n3geUgQaMBu8Ns38/7+2/XAETpEj5NQ5e6oNsauQodp/FKUE8O6Ngjuwb8TdXOiTMgxB8TfST3/+vXIFNaJu66BErxQMgzFW1wfjDf7UkYgDx0qUtNUM2uG9e7tUhwIe6qLY6S0s2o5IBkS0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:QB1PR01MB3907.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(6133799003)(8096899003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?pIEBQcXLZQE9C3PNvPdBtHz76D1747uXYWgMjsazxjLkBZrDYmXhAMlS?=
 =?Windows-1252?Q?xceU6xE7Q1fx7B+kNrba29IXeDYRiKDpgBiGwA9yFSpaG76owr2PaUHj?=
 =?Windows-1252?Q?LpS5CrB0rF91KInYgqCO+jKfWOswRWdpov6zE2fRU3MejGB4PD2NvHNN?=
 =?Windows-1252?Q?+Z7jB4j3H5ZIn5AKKOZneSU/vXfWZIGyFTmjTUaKueeyRH1Sn1KvI4Lw?=
 =?Windows-1252?Q?MxEHCZAvxDTor7GFoT9vlR7eqUmDFidFeu/kPG6vjy9u6iN7LfHrDZKz?=
 =?Windows-1252?Q?2GhY2TwQCiiVYVP1jecXWXXWmImgCrURbRzjLppwgF1dCFLuFUp1yiEY?=
 =?Windows-1252?Q?rozcb06XWcR/AqF4vsyi1V3Jg6Sr0jovgVB6Iw30S09pXBjD1JuZkY0B?=
 =?Windows-1252?Q?Y4w4z+CYqitHogzfMb6oiAkgKi38VnSgN/vsz7r/NP+kgSZR3rHxvsnh?=
 =?Windows-1252?Q?gCx342tgrSrD9lV1zk+YhGkCyHjygp6bJOp99mviwglriXqeCtTRXBQd?=
 =?Windows-1252?Q?K5+tCyYr01EmrndYLmJwSsFrJXJQ5/1gimRGYZ1eUhRx0U+FdWapdSXN?=
 =?Windows-1252?Q?uqh5FYoPlKfH65Zg9jswHpHo3TEwqRGSSMoe85z4Frepzird0NM5rXsb?=
 =?Windows-1252?Q?7BsTQ90w6zDI26EmO1HvtVUyv5Sf9hNu3jTqe5y+XgqqWHHyVdmdN4pt?=
 =?Windows-1252?Q?zgX/ciJBf2COtEJi8/C2CMsigqJggc/zTN5+yXnh1DNP46XN1P5xpuZW?=
 =?Windows-1252?Q?vjVw2abSJKrlofTDcGv0VUABcVyUOyQfx5oFpH8Tfv6GgBFcVBdJzs0W?=
 =?Windows-1252?Q?dx5JSD7iqQMfFR5Eg0eeyLNN9mCwZG9Eq6dds4E+la72Mip3t0jev4ri?=
 =?Windows-1252?Q?VhAmrtO3JlKMUxfDPkG8zjAX8yX7A5vUBWri0rt3IR3UbbSFsBJesgxo?=
 =?Windows-1252?Q?fFIqMAgp66dY02iyZxoA0ye3R2ZEkVI/xPvpAJFuKa4KfTPRlcGDehwk?=
 =?Windows-1252?Q?r5rA3aMd1OAFkMzdBN5QC4vPFLC5TnoGoXUHPa6DqQ0K4h+g8yYmm9N0?=
 =?Windows-1252?Q?V75hZHt5lkMJOAUuJI/ii9ygdDv7JMpIgHi7DCor0VTilRbPBYCi5AVA?=
 =?Windows-1252?Q?qLHjBSuAEZup8jO26cnEJqYnjwFs5G+lh8y6u8NJAcrUACKo7m5NtGUB?=
 =?Windows-1252?Q?B5+3domHesZwuntz24RgbPCWWRbQ9wyaY7eTnljESUE3aaw6mrTcVVpQ?=
 =?Windows-1252?Q?ZykIH42H32d/UEsYNKwUJ1tLDUPXlQ46W23LqyaWizA/0U4NJqO/MxKm?=
 =?Windows-1252?Q?gv3CTMIqCTJiHe6f8CRurypWhxg1n1AMeXydAx6k5pWf7bT+voS87Ogy?=
 =?Windows-1252?Q?4UqxDuLAb8vY2YDhNEK6n7GfH1PSeQZjDZvRhyOGHR0dt8WP9cgjaULT?=
 =?Windows-1252?Q?RTxbZjVieLnxl6hA/GQB2p//U5XH8Ak375AVrILgrOeq9UjWnHs2qEVY?=
 =?Windows-1252?Q?lU/ZNJthAqaRPeu9LwgNoClBHvFz8BQjm/BmRKcAX/Yo/ZZI7w7/psYR?=
 =?Windows-1252?Q?uMG1VtqjxXKli5NFSuPXzmqYCxh/9fpJ+D3oVd6WnKKgwCrYmrXoinl2?=
 =?Windows-1252?Q?mdYvPXiySqNm2M6CbpF47hWRmtVlMttwuuEI6HYtuy8LoE3VyDjcQVGO?=
 =?Windows-1252?Q?vFAPnN8CDGIzW296zdGz1CRl6NV1va2ghC19gi+Wtw6iWZf1nkK/Nu4i?=
 =?Windows-1252?Q?FoRF39sbksRaMDBKonlX7ik0GbvZLezBZoNFnNqhEPwSYpMqR9ZLg4br?=
 =?Windows-1252?Q?WEckeLshFHXrR25aaVz5Aaa3A2vikhtpx34M7E5EZAIqUZ47j6sXS50N?=
 =?Windows-1252?Q?4FI7mwgTP3+Vhw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_QB1PR01MB3907C0D6FEDC794CC3514213EAF02QB1PR01MB3907CANP_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XUPOST9ROY72aNCe2LgkHH48umPZDhx2eAQosxFad2a4xCzXZ9QDrD5QUOdTxh/zcCSSJMrV050k1UAEDYCOJLYoQXup7vMxRyTtIiIzt++lHWWmfSWDgr1vLOa2xzSlpxzHWtVKpjiwPMkKitiuMfzdfBW4kVCjfwjD7S5xssBpUM6J4ZU2NJDbMpQz7fEBzc60wng/dWcGqdaz5KQ9AUC3mcqsL9sxwGNbcPHXUbIHTnxcnodKvv/sSbEC7PvPEpCww9xHxRsgaD+sObpdrfevLZVDu5IwwfQ+fePKCqET/5E4lMHaUpEjFtQiPa9A/ZN/3XDeMwPOfsXazOy24Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RtsH2w4tOG8vTiIzjW9qbRYDGUJuZjsYvqxrxL3QXdAmwQ7MXcmW/QsAynX3GR1AqynvL7JpmrbuDzp4UiPmf+XWEKE5bBAWNe4Clsqld47vaNgeQPuFmpHeNCuuX8d7hrmAGWb2jn0RtAUp9HGu5/i98IjtTXv9/BaIOO7z0y2qGjiNZVDR9BUtIESoX/j9iXKUUmOXT2dzulC+LZGN/pXPx8mMXLVIF7l9bJJnqV+U25/Ep8O3Zi/QtuUd0QHvqjTdrdBAbFVIfldwAyS3riCEBASMQpDSvjX6N2UNoDHs36JHswI3D4UPZ5qz1Qm321F2fO1H1cGwr5t3G/oSQSarerqAV/aH9qrae/zMz9CpFyAvk4BCBWQzQaMolxGgcmss5kkGNEzYJWbzGxdVaz+mfPvRkwKH99+X/8EPJYJSym91rKeCkK3AxqBNx4IOKGiyT7heOg1xbw0p+asDlztO3tgAENicKuab2C2t+Jw8VAlljuukHOs2U0982U6dO4VOd7f/Wb/2qAMTl7mPeWh9jIWdXty8bP6zaigzXEYXDMZJ3ua1/SaBm3GgcM0kUfYGUkJetsw7EqE2KGlHVtXgc+cruChnJtDIpgWZnLc=
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB3907.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e5552c7c-cd92-4478-006b-08dedc4562a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 16:32:49.8000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d1f9ded-bb98-418c-9ad2-e1d24a9152a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZ5m70vwjgx47D30BFxhntIGczl1GUnLUN5UqivIRHouIdvjNXdVEFlvCN8bwfRWAEK1Z2hSIxV3byVq7q/X5DIskvdEBslnkKnno/2VVek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF55F13247B
X-OriginatorOrg: rossvideo.com
X-BESS-ID: 1783444087-110571-19549-14449-1
X-BESS-VER: 2019.3_20260702.2136
X-BESS-Apparent-Source-IP: 40.107.193.96
X-BESS-Parts: H4sIAAAAAAACAzXLsQrDMAyE4XfRnCGSI1vOq5QOTk8iS8hQD4WSd6+HdDl+Dr
 7Hl/zTaaU+dqLzTSunPI/axwlmCZ3ZtKrmKB5ZXdomqba2xELX9Pd7P25fi6Tbb4B6Bc
 zZ5CViJgwEIkGiGOh6/gDKrrTxgQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.274474 [from 
 cloudscan10-180.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS14382 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

--_000_QB1PR01MB3907C0D6FEDC794CC3514213EAF02QB1PR01MB3907CANP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Laurent, Tomi, Michal, list,


We're upgrading an MPSoC product from linux-xlnx 6.1 to 6.12 and
need guidance on the DPSUB live-video-input path.

Our device tree wires a PL-side pixel producer into DPSUB port@0,
which sets dpsub->dma_enabled =3D false in zynqmp_dpsub_parse_dt().

On 6.12, zynqmp_dpsub.c now skips zynqmp_dpsub_drm_init(dpsub) in
that configuration and only registers a drm_bridge =97 no drm_device,
no plane/CRTC/connector, no /dev/dri/card* for userspace.
On 6.1, the equivalent configuration exposed a full KMS device driven from
the live input.

Is there an in-tree, downstream, or work-in-progress sample driver
that provides KMS on top of DPSUB's drm_bridge for the live-video-
only case on 6.12? Anything from an internal Xilinx reference, an
out-of-tree series, or a customer example would be helpful =97 we'd
rather align with an existing shape than diverge.

If this is intentionally left to external producers per PL design,
a note to that effect (and any recommendations on the expected
architecture) would also be very useful.

Thanks,
Itar
Ross Video
----------------------------------------------

This e-mail and any attachments may contain information that is confidentia=
l to Ross Video.

If you are not the intended recipient, please notify me immediately by repl=
ying to this message. Please also delete all copies. Thank you.

--_000_QB1PR01MB3907C0D6FEDC794CC3514213EAF02QB1PR01MB3907CANP_
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
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Laurent, Tomi, Michal, list,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We're upgrading an MPSoC product from linux-xlnx 6.1 to 6.12 and</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
need guidance on the DPSUB live-video-input path.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Our device tree wires a PL-side pixel producer into DPSUB port@0,</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
which sets dpsub-&gt;dma_enabled =3D false in zynqmp_dpsub_parse_dt().</div=
>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
On 6.12, zynqmp_dpsub.c now skips zynqmp_dpsub_drm_init(dpsub) in</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
that configuration and only registers a drm_bridge =97 no drm_device,</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
no plane/CRTC/connector, no /dev/dri/card* for userspace.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
On 6.1, the equivalent configuration exposed a full KMS device driven from<=
/div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
the live input.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Is there an in-tree, downstream, or work-in-progress sample driver</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
that provides KMS on top of DPSUB's drm_bridge for the live-video-</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
only case on 6.12? Anything from an internal Xilinx reference, an</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
out-of-tree series, or a customer example would be helpful =97 we'd</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
rather align with an existing shape than diverge.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
If this is intentionally left to external producers per PL design,</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
a note to that effect (and any recommendations on the expected</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
architecture) would also be very useful.</div>
</div>
<div class=3D"elementToProof" style=3D"min-height: 20px;">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Itar</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
padding-right: 8px; padding-left: 6px; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ross Video</div>
</div>
---------------------------------------------- <br>
<br>
This e-mail and any attachments may contain information that is confidentia=
l to Ross Video.
<br>
<br>
If you are not the intended recipient, please notify me immediately by repl=
ying to this message. Please also delete all copies. Thank you.
</body>
</html>

--_000_QB1PR01MB3907C0D6FEDC794CC3514213EAF02QB1PR01MB3907CANP_--
