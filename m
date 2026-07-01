Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656E6C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94AA310EF98;
	Wed,  1 Jul 2026 18:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Rv+CPxNk";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="a5o+VDF5";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C0610EF98
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:18:39 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661I52LN614236; Wed, 1 Jul 2026 19:18:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=NeULyzlWf00fze/16Ji6IyJram+jwfwv5/s0x6/ox+g=; b=Rv+
 CPxNkFVv1l1l0mbCTEZyPtYkIAfMWHryh+vBDtziqY7JLrkRlqX1eABbvY6INvPw
 lrjeFysQPeDzBBh4D/SFscvPDhwL7NV+2tVwXdX616CTGpVUaxz+g99GFS3KLqxp
 iHYtyxDLR4xJdGWv5+4xfQCPeEL331LeDT3vr+UUxxIWebpj/QtKa0nck1fmQrBf
 LVGOvk+9f6SOGNJ50Nz4PRnPMXZzzdoSaBXr+HodHCBCm+ufAZ/99gznHwk9K53m
 T2uRGr3gW/AfXGyrQyC7jYynhQ52Ae9e37YyWLsL58+xOqXxFb4OG+rOTQF0yOQc
 cvM2uAu93Kq6YB2EB8w==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021083.outbound.protection.outlook.com [52.101.95.83])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kummrn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 19:18:15 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP0sPf6Jqg5mVriTlKcWQG6U0j54oKon8nHjyqtQCnturK0/S1faxDZ/QgBFFSUkMKcUTur5bL/2lYgVTTpvTYQVW1QqTr7/aBxEpXmBirgO00nVqOdzl5noenuhqhrjWXuXEIihr9CG0Pb+IpI75YAM6XIsgro1XdXp5IndDMTE2DPj/zuTODuJt8nXZV0P2aecBgzZW9x4y1b7LHBNoZCZcBVRBOL/YB02kjs2z6U8CtwvDj5cxjzS5dkYD2DFtmIazUmRko/vmJc08SnL4dEgYR5GZMy2LryBbrCApvQkFyWRfP0c3MpSeEW2c9TyBDgxlrK3ZNMUKdiJc94X+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeULyzlWf00fze/16Ji6IyJram+jwfwv5/s0x6/ox+g=;
 b=RDOCOWKza5Y+xfeFZfA/B8tLj9zbzQ4eH1uBw9dha4B+HKJ39Y5OzHjf2vBeWDr1z/JJGCzTzeRAGst988vRGYMAwKxrdhCTJ3MWBBWz3Yd/bA1eYwsUr/A8ijZjykES6g87ubCbpaTaHygt7NoaHcRVRhT9SPEueLqay9LkcpHHb0kDcxaaz2frMH4R9nY15xWpvO1pymVUCORvwA3eR/YokErwlt0DsJUAzA+PHwKq4TfrmJu7xFrSpgp9D6cbXLg854j+kj/8Nf3d2Tow+h38fbk4P5ab+hlMDM54xIUVitxeRgUQwzzC5POkb7ajlaTovfUsVIrx9Mzzgxwpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeULyzlWf00fze/16Ji6IyJram+jwfwv5/s0x6/ox+g=;
 b=a5o+VDF5y/ALuJ2O/tcVNUZfhV3enbru6CagsNBihHXFGT45irLLOPGeYhmbyLsMljYvyDJKJNbz9OCljhgrhwOZQNufcb3e2gEnO2iNj1aJQrb+UOQ8PWgFYHHH70iPvNN0AldB6Z0ZY9gLboFYSaSLykbvr4OEmCBpksy/+Bo=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO9P302MB1953.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 18:18:13 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 18:18:13 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "Matt.Coster@imgtec.com"
 <Matt.Coster@imgtec.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: make pvr_fw_trace_init_mask_ops static
Thread-Topic: [PATCH] drm/imagination: make pvr_fw_trace_init_mask_ops static
Thread-Index: AQHdAv6cDuELNuAwok2enfCCyEYJ8bZVaGGAgAOdlQA=
Date: Wed, 1 Jul 2026 18:18:13 +0000
Message-ID: <8114990b991bab4ad2b1ee97844db3c2556c05e7.camel@imgtec.com>
References: <20260623105341.775693-1-ben.dooks@codethink.co.uk>
 <055465207ab6f86f0d12b73a592bbecd9768c8f6.camel@imgtec.com>
In-Reply-To: <055465207ab6f86f0d12b73a592bbecd9768c8f6.camel@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO9P302MB1953:EE_
x-ms-office365-filtering-correlation-id: 9e90e2ed-afb4-4151-5409-08ded79d1d46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003;
x-microsoft-antispam-message-info: M2IWjTEAJyLDPmlBQZHPko2VwjH/z3wm8KIN637Ip9aVzUKdbxmeKVSpqTZyhPdLLSug34c+1YPG7YxOfQ30YGDdzM0I79Dz/zdd5erwh9qczf+XSMOSPbFX15XmTQKxJdpJy6Z5loLruoBGxXQh76ttmGJP8PUNpkbdPLnivb0LDrkQ0WsBM942Uh+5OHFsqiL9ZUUctHMqOVishRbxvS+PmnxALg4AsSOe5qk1iANvg2SpKU83Jh5SqGOveFbKjKAdPsCH8Gn+0aI9O5XDwZZMFBB/9JmItp+uVCxosvet5AlCaBbVV5xcQe7lQx2LYQBE8MXtchWOGc6PwJ4PWaBvtExjSJ/ojCznbqzDbN2Fxyv3diZL13tBZCBmp2DwweoRu4V3DO8bdQx47sCqRMZTEVoeD08xKIBZiwfFap5aD8dqeBAX6FabNJvXqhwJpgz8xodt53WsAEYKIJ/cXGGPxbYuSTmqt1gu6gMuhSG38HbiMNca518KyeRGRYwMME9Hyx0aXsDic//CQ+v3a2/Ax1dYA6hrbUaYI0XgpOd+LjZwNUuWJIkQL1KM/V3+ykzunlgSSperWErADdBJSSjzPXn3ccZ0okBfk3tG+NyIK8qpKIbHBJxw4es08n3i/PHyCNrb95jOr02txWWSTEzq2ZJBXKGpry3cWhNcnxIdy8fUNAXyvwf8AW544k3LsOQs0YG5aMugtiA8uaeoJkYEkBbc1JyqFJPV6KD1wR8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVBmeHROeHg2VFg0R3pHMXEzUy9OSE5OYlV2c3F5YnpUQ2tMTUdkL0dCOWRq?=
 =?utf-8?B?Q1EraWd1NldNQXBuT2dyM1hYK1Q3OE9kc3FCL3hlRGdDL2g1SXM1KzRGWVR5?=
 =?utf-8?B?TnFveFByZ0l5WmZwcVA5WmFsT1VMbnozeTlPZDJ6SUp3VUJubXl2UEtscWcy?=
 =?utf-8?B?VkJKTTZkZ3NBeCtVY0xEbXVuVFhMYk5qeXJjb0dsOXg3Y0JtcFpjMEoyZU1j?=
 =?utf-8?B?SE1aNU1zM0pLMm1jcFQ3QTM3YVlJMG8zdjFUdVF0dFNuazdGRVl0M2x0T0hj?=
 =?utf-8?B?c1hVdUJzOHFMSjJxalV1OVIrNVB4MW9iRm9Pajk2R2JFSDlqdjFPV3Zaaklp?=
 =?utf-8?B?eDRWbGF0MDgrMis3QzUvMzlOVzBScXZrVVBFTDl0cG91TmpiVno5MjhMUnNR?=
 =?utf-8?B?bTFQMlU0WWZSeTMvWSsrbmxyeUR6MkRpVVB1SmNUdFZhallsRmh6ejRNMnFN?=
 =?utf-8?B?UkM0V0NVOHArTTJBRnNpTzVQS3FDTFkzeG9xR2JOK3ppbFNUTHVEUFdxVUw5?=
 =?utf-8?B?Uk5BL21CZFd4L3Q5aWRwakRDaUVKM2F1S1kvbHVaSlM1WGk2UjlpR2h5ZkND?=
 =?utf-8?B?K3Ftb0ZiclpnY0wrNEVDSmZ1dHVXWkdoZkFheVJTQ25ldHF5L0NlbHVpdHZo?=
 =?utf-8?B?Z012SGtXSUxGU0t6a1JHUUJJNk9lVHZFZmNPV3djMUpTT3QxWWlZbjI5enZi?=
 =?utf-8?B?ZnJieE92NkkwTURSVWRYSUE5SWhONkJZeTJxSFZnaW1PZHpiOUkrYThQUVRl?=
 =?utf-8?B?Nk5FYTg5UC9sUlZ1V3ZwU3cyaEVublFFTzlISDY1cXZNSG1UMjMzRC9GNzRM?=
 =?utf-8?B?WmttTHdWb1YwcjlkZHBuaGVNWWJxN1V2MURXMnFEZzV6Nk81TEdLUjJ0a2Yy?=
 =?utf-8?B?U0Q3QkxDbnYvT1BOYytCbmJOMWxaWElKN3dpVXBScmJqZWlXR2s5MXFjSDJn?=
 =?utf-8?B?ZXdlTUlSN1lJeHU0REZDdHl4bGx1RVNzbFlYR1FYSWFVSlZSbFVtV0hFNVUz?=
 =?utf-8?B?UDRlNk1yaWZTc2Y5aHE3d1VmdU8vWFRnZFIxSlg2VkNybTNkS2lzUjlGQ21U?=
 =?utf-8?B?c2w3THBiZlpobllUMzVocUtJR2xHSzJtZzl4VVRMUEl6dS9Gc0JHVmVsSDlW?=
 =?utf-8?B?c1JrWVNlVHp0MHVGbWwwTmpxVm82UGhvT1Foc2QxTTdPRldjOEg2aUt6SVpn?=
 =?utf-8?B?T2xUU2JnR3ZCVWNVY1d0cjh2L3g4ZzZ2MGZFSmlGZkxZNm9SM3JMaWtpdjZE?=
 =?utf-8?B?VktHRUJtaFJZeW5hejByVUFFNXZ0cDZwUVIrMmlIcGhKVy9NTkkvRmtrWnFo?=
 =?utf-8?B?SjlNNDF6TGN5YmpyU2M2OXN5dDJBZGdodVQySVcrYVQ4d3ZvSlNUbkFBRnBI?=
 =?utf-8?B?T1BYc0dTZ0hObjZ3b2x6TDVyYnEyTno2a0Nrc08xanRCZnJNZlczYnpmMThx?=
 =?utf-8?B?MjFqSG12YllzSUZpdC9qTS9TT2ZMRnNpYmNJeENKcTc0d3BsbW1keXFhOVJG?=
 =?utf-8?B?Q1RsOTMzb3hLc0hIdFZ5OEF0OVozT2pScldHWVA4bDVBaEtWeDBjdEhWZk8y?=
 =?utf-8?B?NGFKbUc0a3Y0cC9mVEp0UUFRT3hzLzRiVFZ3RGV1WWdFZUo0Ukd2cnF6MU9E?=
 =?utf-8?B?T29nWDY0WE51NEk4ZGhLTWZvZ1Q3eVF2aW9SZzYydFNOd3JJQzQzRVZsVnI1?=
 =?utf-8?B?QlZQdWZaNnJTVGhuejRUU2JUYjA3cGJiZ2ErRG5TL1J5ZS8wNXFzME8zaTlw?=
 =?utf-8?B?NWlKY3J5STlQYzIyQkZoOWx5Q1Mrcm5zcERrdjZDS3ZHcjc1WXZvL1R4M2RC?=
 =?utf-8?B?aGM4eVAvUkl4N3pYbnhYQnJQSEZ3aWVUcnRGdHpRR2U1MVFsWUNZQVZZWkJD?=
 =?utf-8?B?Vzlpd2kyZVJCcUZvdnJiZERJTmIzQjgzNlA1NjRFcnJuRXpVNEVKRU9oQk1i?=
 =?utf-8?B?Rk5kYTAwSFRCZk1SYlArSXBuTmRvMmRheUtPRElDSm5aOFdXcG9mSW5UYzdU?=
 =?utf-8?B?ZnFrRUMyaWtzU3JPRG1sajNkZEhMQ0lnRFY0eVNQclB4QlNJUkloS3g4RHZH?=
 =?utf-8?B?V21RWDZhZmdOcFN5N01IOElFMUVPaElzdDhqcE5rT3JqcHFJQmdFREFFN2cw?=
 =?utf-8?B?MzNiUU5hMk9VTWhnUTRxWnAyKzJJanBhb01BTE80OThWUDRadUQ5ZCtLb2sv?=
 =?utf-8?B?dzRDR2hOd2NVTmJkdzRyOG5QT0I3WWVzeHhCSFRFQWtXMDVwLzFGR3ZjbXIx?=
 =?utf-8?B?bi9DODl2Z3pmMHpRQTJVWW9FUngyRHdsbTAvRFZPSFk5YkJBcjNhRC9IS3oz?=
 =?utf-8?B?ZXl2QjZPSThpb3hJZzlkRytLSTRmVmlEbHlFVEczUW1PaGw2Q3FGZ1lhZXg2?=
 =?utf-8?Q?XVEQn14rnBfS9tcE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25E3D3A938C5914ABA05A898255B74DC@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fyoODmfp+fIBaWkrWOexLOaKbGfdFCs1aDNprL60ix0dZXS7IjIYHSwWbygeB/6vslgh+OH2x3vCjn2+vg1Z/pkOCS7A7RIUYRZQ/THZBxRIpTfD9OZF48ljWkza9zeqGitj3svRHrde6TpzJjCGZBNmNU+kgtEuFVm+MVpe3d07Z7NyG+FWbbl7mq7nq8IH3c9G0MON/802PEnMPOl4y8VIJB+OIh/+ol+Y5mQvd4xmjCwukBvqu7lWE+D3HcYvWDMjV4KnHsq+jsnR6ykHtIItluJ5Cs+g2ez9+2mB4rJGIogpko/twr263woPeKZXyKDZHOyO0kGMLxahedYuqw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e90e2ed-afb4-4151-5409-08ded79d1d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 18:18:13.4018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoCqYpIdaxztyD3VZR+lgVhROMtdWSJqpeOU9+VnyI7DteoO6yta/WbVVhsF9NqQoR1MyW2I8Xp32+CT2TqD6NYTb4MjaY2f2zuhZUhIOO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P302MB1953
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a4559e7 cx=c_pps
 a=KhLWtWQbQ/x1DB0ev6mPaw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=1EsaE_6oAAAA:8
 a=r_1tXGB3AAAA:8 a=l1aXhcXkrV-Zk872pGkA:9 a=QEXdDO2ut3YA:10
 a=3ZumFrijQQ-2J9H5h8ct:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: XLWhvgCtv0W2djAYAmt42i8gUDNRqfVX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5NSBTYWx0ZWRfX0SlqeLCmbV42
 0EXlQKuc6Tbp7Yx+0vHpVMHrvlaU5DV0qJI1dWaEikSNcr6XddzBwiBVEVu6kUCzTDYgKsHaS8w
 FCJ+K+/BkO5lYU9hPpfYCAgOCbfNHJ6CUBFW3K7j3juBrQ3rMxHyK7dHuty86/hVbNOdBwcsQTX
 hE5GQFDAMFoBzcK1H1ZgLVoLC1EuddulqUKqbHxJFyRpJOf9Vey2cTZotlZSI0C1sDe134u3gZ1
 clzdoZtpBXLxyi+zCnuS5TY/8SvzOPsC+5mcjJemUvyG7yNdKnxD+PVH1yIuyfk86aX1VxeFEC4
 waLNFLq6RaIFdF8X+8gdeh3shI558Y8jhUu3SPZRmSrAbeLmhkQeWAvINx+u9e14K9k5sEpm8Sm
 M/5KtxoxjQ2+lAvAFBRt8t3xgt+JVvgBgOHCjhgung9G9Wlwt57lYPfDYGuiI+fahk4BfipnNg0
 h0H056j4S8CcYrUIhEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5NSBTYWx0ZWRfX2cT89TpST9TR
 94J9PJHRyRS8KR6ZpK98BW7NscowG85/LZEQCq3QEKzlFyyoxyjyaEZUspVD0ODeAStujvPTFpI
 A4cHwMLFyWL6KiK60fp0CiG9KggB3RI=
X-Proofpoint-GUID: XLWhvgCtv0W2djAYAmt42i8gUDNRqfVX
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

SGkgQmVuLA0KDQpPbiBNb24sIDIwMjYtMDYtMjkgYXQgMTE6MDUgKzAwMDAsIEFsZXNzaW8gQmVs
bGUgd3JvdGU6DQo+IE9uIFR1ZSwgMjAyNi0wNi0yMyBhdCAxMTo1MyArMDEwMCwgQmVuIERvb2tz
IHdyb3RlOg0KPiA+IFRoZSBwdnJfZndfdHJhY2VfaW5pdF9tYXNrX29wcyBpcyBub3QgdXNlZCBv
dXRzaWRlIHB2cl9md190cmFjZS5jDQo+ID4gc28gbWFrZSBpdCBzdGF0aWMgdG8gYXZvaWQgdGhl
IGZvbGxvd2luZyBzcGFyc2Ugd2FybmluZzoNCj4gPiANCj4gPiBkcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX2Z3X3RyYWNlLmM6NzQ6MzE6IHdhcm5pbmc6IHN5bWJvbCAncHZyX2Z3X3Ry
YWNlX2luaXRfbWFza19vcHMnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmVuIERvb2tzIDxiZW4uZG9va3NAY29kZXRoaW5r
LmNvLnVrPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVA
aW1ndGVjLmNvbT4NCg0KQWN0dWFsbHksIGNvdWxkIHlvdSBhZGQgYSBGaXhlcyB0YWcgcG9pbnRp
bmcgYXQgYzY5Nzg2NDNlYTFjICgiZHJtL2ltYWdpbmF0aW9uOg0KVmFsaWRhdGUgZncgdHJhY2Ug
Z3JvdXBfbWFzayIpPyBZb3UgY2FuIHRoZW4gYWRkIHRoZSBSZXZpZXdlZC1ieSB0YWcgYXMgd2Vs
bCBmb3INCmxhc3QuDQoNClRoYW5rcywNCkFsZXNzaW8NCg0KPiANCj4gVGhhbmtzLA0KPiBBbGVz
c2lvDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3
X3RyYWNlLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2lu
YXRpb24vcHZyX2Z3X3RyYWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3
X3RyYWNlLmMNCj4gPiBpbmRleCA2YmI1YmFhNmM0MWIuLjgwNWQ5ZjliYzFkZCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X3RyYWNlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X3RyYWNlLmMNCj4gPiBAQCAt
NzEsNyArNzEsNyBAQCBwdnJfZndfdHJhY2VfaW5pdF9tYXNrX3NldChjb25zdCBjaGFyICp2YWws
IGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW0gKmtwKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0N
Cj4gPiAgDQo+ID4gLWNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIHB2cl9md190cmFjZV9p
bml0X21hc2tfb3BzID0gew0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbV9v
cHMgcHZyX2Z3X3RyYWNlX2luaXRfbWFza19vcHMgPSB7DQo+ID4gIAkuc2V0ID0gcHZyX2Z3X3Ry
YWNlX2luaXRfbWFza19zZXQsDQo+ID4gIAkuZ2V0ID0gcGFyYW1fZ2V0X2hleGludCwNCj4gPiAg
fTsNCj4gDQoNCg==
