Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72058E7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BDD510F414;
	Fri,  3 Apr 2026 08:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="gZQajF+p";
	dkim-atps=neutral
Received: from ROAP284CU027.outbound.protection.outlook.com
 (mail-brazilsoutheastazolkn19010004.outbound.protection.outlook.com
 [52.103.22.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081EC10E254;
 Wed,  1 Apr 2026 02:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS4N6ixzojdR4DD7rCylfgIUTTDKKyav9ZHgTkwNE9QPhPkxo14bYwTRRFqVV0NLSAHmHDCTHEnw7DjAUBEXsEKgvE4Rxka4WrkVmo/CkyCLazAVCjBXPNO5TFYrh8KNyF7IoiiXkZ6BccpsgZbNMAyuli2PS/n3KI7KSEa3ffr3wQxCgKb7dCDucI9jOAqITf3vzHiCdw077Wi7HsbFBlIxm7iByRH56MpQOtFaEDvfeASDoAXs7vlPOjDyhKfJ4lVftNi719nUcm0uKkhpFOpOYAK+R7mVRQTC9/h/8RZadyzaWbt/I8aLjZ9fhCEbdyVI9fi+UvR9IXvBiXW9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV8aWyxyMPTKwF/2XdAYkcHAwP9h3AZju/HxscR+AcQ=;
 b=A9RPh7lO0HiF9yf/H71FrUPBNdQSVsUfJjudMvUfe87O0yKg6NtjwCesWqaX3VKluzB7DUoDoMUfVFzHk5SLToTXiGDLbplgqsJZis1If6y80SQidtmiN1E4AJbMWZ2/uLTah9VuvC20LLDcWeE8I+Q3cuNpF/+qq+9cHNKkfQCwuvbCNQUFTCxYjk5YSFK5fp8YACrrtS5TaUmFr0st5lYAPy8bT6yIWz6coO0c4GNgKLRIWWsuJlvFwcQ0HFDLQHl8NRJJTRpYoUkeorLOty51W+XggbeoTowmq8zwFTR228qu96y1ys8t8yyoKcNufNjHX5WGhnNCEvGF7TCuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV8aWyxyMPTKwF/2XdAYkcHAwP9h3AZju/HxscR+AcQ=;
 b=gZQajF+ps/rKWBi6w9nHKWbLPfUokfNQEebk38aJ+LEs/ZIlkqfqNV8G8d2JgioNQxOX7FJkXSp4tIiQRjXSy+ZV2qReiEL3hH+9UohNL+fB9g/UnJ6leKpMewOG/DD4AwRE1/Sf7NbAxU//jX+/NkbFBW0dQgQ99OIr8+F9aRYjp0E/GUSqr2wUiunwZ6Y5PGffCrc6zczDhnJMa4yiSqNANsi8mvwTE75iJyXGTrLPqonzK4gLgWiahnm+vSZvSFokCcJa64pysmwOWXCcdHlmEfn3uiw3VZaILtQEyu/o1wAPzl46d3cdhboB4cO0vFJ4t/4A4XBiJumhddXVGQ==
Received: from CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:38c::8)
 by ROAP284MB2187.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:db::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 1 Apr 2026 02:53:17 +0000
Received: from CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM
 ([fe80::2ed0:cdde:9d51:f021]) by CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM
 ([fe80::2ed0:cdde:9d51:f021%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 02:53:17 +0000
From: Yuri Martins <yurimartins2004@hotmail.com>
To: =?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Matthew Auld <matthew.auld@intel.com>, Matt Roper
 <matthew.d.roper@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/xe/bo: Cache vram_region_gpu_offset in struct xe_bo
Thread-Topic: [PATCH] drm/xe/bo: Cache vram_region_gpu_offset in struct xe_bo
Thread-Index: AQHcv8qW1tVFDIs+J06SMan3VDTalLXGt6QAgALLZ78=
Date: Wed, 1 Apr 2026 02:53:17 +0000
Message-ID: <CP9P284MB3908EA888D29440A8129DD62A050A@CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM>
References: <CP9P284MB3908AC9B3875FD63E955D139A055A@CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM>
 <10289571cccff20ba52f224080754705c606ccfe.camel@linux.intel.com>
In-Reply-To: <10289571cccff20ba52f224080754705c606ccfe.camel@linux.intel.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CP9P284MB3908:EE_|ROAP284MB2187:EE_
x-ms-office365-filtering-correlation-id: 3ccb80a2-eb9e-484c-6266-08de8f99d3b0
x-microsoft-antispam: BCL:0;
 ARA:14566002|31061999003|7071999006|461199028|24121999003|22091999003|15030799006|8062599012|8060799015|19110799012|15080799012|20031999003|39105399006|55001999003|24071999003|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SmqYEX0XyvUPrl3Q2XeDkudcaSRk60K/gxjeNWCXKOKc4v92ZWuetzb7M5?=
 =?iso-8859-1?Q?2C3oY6rodVi/s8pvHE/nfgV7ps9L0ilTe8yZ4EYZOTcRH0bM9+GnBrQaVy?=
 =?iso-8859-1?Q?ueLXETW2T85Aca6OMu7iXgyCxQJ6QPuvhzP9FjFQjBfDmyfmMtzyQxrfyI?=
 =?iso-8859-1?Q?q9ikXhls5PM5rtqPOz05uJDlgATauQ3whk0NZFaDGBTgkLxoYlhJplnoA7?=
 =?iso-8859-1?Q?1t75lLyucy0dNMuHUuJlg7Ykb0C+aFcovtaaUK4WNZd3vWHgFo9glA7h55?=
 =?iso-8859-1?Q?t7lzlrIJKXmNIqJ7/6AGzZxr8ZstditnQUqpcj4yrKFWqoyMAFeHUzqJ/L?=
 =?iso-8859-1?Q?HxqDcrUB+wIuI/OYpZiC1OGWOXGbMgvuXH29ZuoqXxEsn/zcmyI0/W2ypw?=
 =?iso-8859-1?Q?TFBcj5XPH+S0C6+2R9Ta8oBI02NjgSQ/XRsLOVnqQjvc0Qj830A7PNNauU?=
 =?iso-8859-1?Q?GkN8huphifCfNUURwB6bkCwzikkIvr6xCKCxteKsufc4HLxjJxVViQ4TGZ?=
 =?iso-8859-1?Q?+gUCcJ5VoR3zivCaJFuxuuZeohpmZ5JhNbKKMFq6xZ2w3/SQ/cgtxKXXE2?=
 =?iso-8859-1?Q?8s8RoeDdqtRWY222GsQqm+5GnrU/Zd3JhpyeBF2Lqy+LRzg2+W5DuKJtPz?=
 =?iso-8859-1?Q?ifcf16zgI4xlBB361DXrjOILb8ZpMXIYHA5M65d894Dhz8D2zkjXnH2Tvv?=
 =?iso-8859-1?Q?nzzx+jJC3ej+ENnjQCyOwTap+MdWeZqiOjUivXt1EpdwaWJqM35uLNZE6Y?=
 =?iso-8859-1?Q?5Cj2s8cbYN34R3HdWn+AwTJ27loFqR3GqX33J9yGsJz/35B4DZ7V1iTQL4?=
 =?iso-8859-1?Q?+Nyq9JE3e5AQkxPkoKf/1fuwzhxrKm/OUCwm6mRaW54ueaXuCVYnt+ps2Q?=
 =?iso-8859-1?Q?vmOlOQjU+8ELb2Zh57u1ocTxI4QKjLayLrgGdhGxr8eNIwCRfuqbsXOugZ?=
 =?iso-8859-1?Q?iGRJ9Lh3lJk/eMl0HvowmtDhLj9/m1ufsGTVzNvvuqdhOHNoBchUVR3RPd?=
 =?iso-8859-1?Q?9B+vYI41MDfnPdTA2WNNwsmSgAUoTxjpnOcXjftEvjGQF6xl2KU3IqJn8+?=
 =?iso-8859-1?Q?5AsByV/GaroLLx9jQha2s13gCspyvBJzLXH0cnvJnrNHiqAO2gJUGS7U2K?=
 =?iso-8859-1?Q?H/OZO0tVY0VzMm+mFbxGiM6dRsKRYGbnhbmO+MvI/EdWcpa1md?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z7PLRfy/c+rB+SCpUFRMNkk0tMDx6Nd0AaUsYrdP38EnGsE/sDNr/ETRiu?=
 =?iso-8859-1?Q?iT5xQfu2MHohcALuAbYgvN+MqDi6550wF6v2jdQ/NzRNKbVZrK5NIshFL6?=
 =?iso-8859-1?Q?q4Eb5Wvzlo0Saw8yV9ETqtuMzhm8FA/DWSeFfhJVhxKCE65lHZgCqo3lEW?=
 =?iso-8859-1?Q?1WWVW6+4dL+2cJPzZmGPKRwQ/CUDeSmTaLxmrKW25exTO5jMnDdhtwlWSY?=
 =?iso-8859-1?Q?0qxO7eHEVH+AIn8Mb/iQ1kLvk7mQz2mqQ+nFLWhlLaIDutWwwCkuWIYND3?=
 =?iso-8859-1?Q?aCa8fB2xSkjcKGCkrZUn63goOxmckxqgI6eUU8fuKpkgWadoUaJVNeXaRZ?=
 =?iso-8859-1?Q?C+IGLVCmG4Bo0UigykcnNiOi0jY5LY9wMyILX1LemJbUX4RXqE0UFgZIW9?=
 =?iso-8859-1?Q?N+JjBB4ZYGlGKMXGXFXSOolnnyyyKpHw1MynsOxm4wh9E+P/1Wwtxp7U/e?=
 =?iso-8859-1?Q?Ojwg9ytNxgrVftSIfCfTCVvcqDgImlPbTjs3GEaQC8RjNkZQLvLzVYA1Eo?=
 =?iso-8859-1?Q?b4j+B3x9ldmPoT4F1XSXvDNeiySufMEyi+93C3CCj7y2fgMjKWMC3Hqak8?=
 =?iso-8859-1?Q?1M4AzyQJ084k/O4Q71ycuGnImx366QjHRhgiCpLvL9It2ZHJ9i8azTcIN1?=
 =?iso-8859-1?Q?vgpWJt49lrZT7tsVmLkzmV5hA4RWsERLWtq43IMNkd+rIvX9qFAh+a9U4f?=
 =?iso-8859-1?Q?wPrm7QHCVs501AHYaARkk51wuIUnDOgEJCs5zwTvrC3Mle789w7U6UgnEP?=
 =?iso-8859-1?Q?HuEIJOziBTwZHjqe3YLseqmAoV7KfodvY3aKihXd8kDKPQ1rStzL3CAwmi?=
 =?iso-8859-1?Q?qNuFPUiiqvW10vROu2z8gIKUWR8oCappchGHsVxd/qQkmcDnEOxb+NRavP?=
 =?iso-8859-1?Q?aH46QobGQbuNWCcEXGnusY0KjJkzh/FzPstDVttjF7l0kozwjrkyD4wszK?=
 =?iso-8859-1?Q?4xyW7spu+ckbnhJMDtKR423pgCh6i+8pJBqHJP0hbMFtPDGY0G8ABi+b5R?=
 =?iso-8859-1?Q?0y0zv/99ZAk0IQd9I03nmkbL66SYTkhxKrPaEpMiF0oXahT+W07N+WvBh4?=
 =?iso-8859-1?Q?apa6W0Dygo33vsredi5ki4AHo3xIUFgH/PKUmYFdFgzn+G6YJjeaVGDXfR?=
 =?iso-8859-1?Q?eP5Ufj1DGsnXOu+sAa+MVQFBs1pQR4rzD7c3up1FMnxVTaVIRvws/AZksQ?=
 =?iso-8859-1?Q?06agomVyubpGNfqVqD9q5qIRqhTvqs4NnQVFr1nCIb+LLZffzDrx7dHnlF?=
 =?iso-8859-1?Q?6e7EuXHDpgVZ0jyhFU+P6eIA+Q6q1Eoay0NoCH4TyN790J6I06b/4a4J2r?=
 =?iso-8859-1?Q?F6BbjhWmj5DWhj2vhuahbOoo75U1QC5EXKrzU6F3yVzDIEbhrpzyokmkBk?=
 =?iso-8859-1?Q?ED3QDfRKUx+zyiK5iF4geQPc035CQpYmBGESU3bYZoFO1HAeN43bauSZqH?=
 =?iso-8859-1?Q?zZHGZR2R1PwnsiMQcStknmwaOXyuPYxYx/Yz6FRVhL3NFa7b2jpTq0Cr+I?=
 =?iso-8859-1?Q?O52cbgt2oCZwcCnKIjIh2y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-da224.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccb80a2-eb9e-484c-6266-08de8f99d3b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 02:53:17.7238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ROAP284MB2187
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Hi Thomas,=0A=
=0A=
Thanks for the review and the detailed feedback on the move_notify pattern.=
=0A=
=0A=
You're right to ask for performance data, I don't have any. My hardware=0A=
(Core Ultra 7 258V) is integrated-only, so vram_region_gpu_offset() returns=
=0A=
0 and the path this targets was never exercised. I should have realized=0A=
that before submitting.=0A=
=0A=
Withdrawing this patch.=0A=
=0A=
Thanks,=0A=
Yuri=
