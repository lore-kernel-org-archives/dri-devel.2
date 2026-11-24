Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34F606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=j3fJPECO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E53810E536;
	Tue, 24 Nov 2026 18:50:23 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010049.outbound.protection.outlook.com [52.101.229.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893BB10E536
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCwVQXn0lXQw1HVklC++qkx+UjmfCDj8T/T9+LPgVXvKzFgxAC6hABu7ST0iPOL7DvFbIlPAUbv8ybHafkDWPxO+ARDCp7oy0lpq9OXJfGQ/HnqzNkuQ994wkU6x6NuWVIotUpoMLn63u2KtZgDSc3srLnylM6Xipr8Fygye2g5MkvzL6B2Z1ohuR5QrLvFmP57ixHl2ZXyBeyOrJmRDyWVwLc7jNp+IaJb22U4UwQHI9tAytnQRWOGl9mmquA6hGbMfrhJxLyHqLYJopVOxH2G/JVNYULG8XJLaVoKdpW5FIx/DyDf+EAO3G5uTvWrxuDzppb6488T1siAYiTReJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/L089tmDxWfsFQycIuEojc2vJxjf3DdhHw6qtn5JEA=;
 b=hxo9cUmRIByIlBRStm/UMGiYNeEQ7wehCHnNtJ+hZtH9JjTObhGHntGryvn6DNYIZk8zC0zBT/sD/y8MZ5LHQK6Vky0gRDagDGzBcNAqnK83UN/zMs7T5Iu2rGJa1t39GimQ2wY8+g1ingNOYTtFKre9MqQcfugy7e3VfRoh8NfXClrqNuqXDTup7ovi1X3lbFR8MMpoEcWJbgjE4UyRg+77meLqXGTXsz8pWSwHulyXbA0ssRGqa5IBwzEiNe39psCYv7cKswS+ZlTrhcXojekk6GwDT+U6u0DExEwaGtjC4e2nLODj+EgSJP4TH2EDWSbd3t7pN4c55MKsQv+IKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/L089tmDxWfsFQycIuEojc2vJxjf3DdhHw6qtn5JEA=;
 b=j3fJPECOELSLzHW3ynqQ4ZmZTui8NB2HEehl3sYZL0AtFFAOjlsq3YemM2mKB7WKwYfm8D73uoMEgIoq4K8ducI2JKizzf5hSIzYg1CC3gochpzRVbhrpMJelhdLjQXI9t6oOcK2y+ttdvtlG1Lp+oH/iSGcVfO5qO/fT7QDLAo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12880.jpnprd01.prod.outlook.com
 (2603:1096:604:340::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Tue, 24 Nov
 2026 18:50:13 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Tue, 24 Nov 2026
 18:50:07 +0000
Date: Tue, 24 Nov 2026 19:49:45 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Tommaso Merciai <tomm.merciai@gmail.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Message-ID: <awXcSSnNeaOQFQZ5@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
 <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV8G86QIth4GtaA@tom-desktop>
 <TYYPR01MB6603A1FB28A473A400A2C49386442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWsGjt6cW_CSoMH@tom-desktop>
 <OS3PR01MB659637409ADFF9CFC2AD395186442@OS3PR01MB6596.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB659637409ADFF9CFC2AD395186442@OS3PR01MB6596.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::18) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12880:EE_
X-MS-Office365-Filtering-Correlation-Id: 73458635-8698-4c58-2f43-08df4a5bc279
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|52116014|7416014|366016|376014|1800799024|38350700014|10067099003|11063799006|56012099006|4143699003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yCI16hax1pXk6h4vQ8tIO9PlN1Hg3yjVGO0ew2pFfIVjJGjrx2YS7VVwsu5AYH06oibZwHXbBPfItUGJt770DYxwfFU9ZUKowoMaBLTP0VXteLEAD6C3PLF+sUhNNpVvkHXHUjost1CrRTIqj9xiBk37KYX9QR6wcjDvSaYU4hRxyvkpriMCWiVl/LUCaZP0em0kOxreKVAosl0VwYN/wppMFXcTQ3LsZIBy7SO92Fch7KYxObh0FARj0n0rJAXFphR/gWGO1+EPYI2BcGk2jz3BRFt8HDtG9iwztq9NjHYL0gFX0BHpcRuJh0nblTSk7TqhsFmcMFxz9wxprzoBYUAE6laa/qizukcBAaxiDM6EoZOpKjjmgdZjtWSlzUboLwuwM8EUzZnWsBolto/oHYzwzmhVEXhm/jMOoO0t3sHMasr4Dbz2H8kBXe2qvz46Ef1YIMX8BJbdqjkfdyw8kA08wbuocx7HWBN897+FWfrbKChrBMjcjkLqJONWo7iZumLt7n3vYrLika49SJRICNc6i7M+7xQRijdgsxM0jWOIG814+DQxeNlpoFkbuUKuSKmDGv3W8/u74sgdJSN+MA6F9Xc+3i+GZP7QJ+xkfrvB8nYIx6B+3vdQRutLHGec7RGA0oAHkE6GCnVO9Eb5j/q5aF3tvSqETLAdkU41175oUViJ0+fsLqh2EXbuLMMpEaJ3MU10zk5PdjYc1gzjNMligjXoUWxI9Cwma5Xjb78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8y2pgo3IBf40aRw62GmNHB5W8uxZ1YQRwhAAOcWMhVNCRPOsMW59RHH7I1JO?=
 =?us-ascii?Q?ngpn3viS549T+EhAdHK3VTunQpNqINaDdGFmRgq1wECTTUpHzpS4z1NMIb6K?=
 =?us-ascii?Q?gqLEstNqF1moxVi3aT0kwW76ccdhNqAz32hpIzSlbTJLroY74sMhHLF58Nlf?=
 =?us-ascii?Q?LgqA88Z1iW391tSI/8q4QXdnJzTqW++kn1l0i0QUWI7WqhQcgKio663FPyje?=
 =?us-ascii?Q?LXR4OHkMkMaAzP4kFRNEaxEPwsOcyVZcOzZS024MCk8ISpX2gH4GWjaMJZxR?=
 =?us-ascii?Q?n33r+APmz5spfA71auXCvidKJG+Jo3nKh5m0R0c34IXch4n9j2D9QZPAcovK?=
 =?us-ascii?Q?Uu0n6ANpjtghuXaVIVHTsZrvrk/dDYd0Xphhz4jJ34FsPQBj5y03b9+1z5Rq?=
 =?us-ascii?Q?TYpHM+cHOEy9hPY6ChA5zOBO4IRqeQBSmVKA3LNbjndWj2NrHAx22crPWDCE?=
 =?us-ascii?Q?glf4i72tOQi+txTT695PAG8s7mypEwfDkPRgyHL2x18GuJ3lKcMAg6U8gj/S?=
 =?us-ascii?Q?6vDUXIjXijTCEPm3hUy7XMIrXMjXpIJO717FznTZZtM2UAXrjiePm8k5xDiV?=
 =?us-ascii?Q?DZYw+nWoufjNfv7GAPPGTrm5Pxy3Bo3nSBU/ljv7R9hubM4xRawOy8BVaqbD?=
 =?us-ascii?Q?uPxpEh4yUynDCKFWOIzMi+s/91NGDOMFrWWjHvaLZxqYkeJ2nt6LYjwi/Wzi?=
 =?us-ascii?Q?HXWkcVGVFkHTjIW/7CaZwEOKNCxwk+o0WUTHOLjELtLb3Rv2eTxC4XxDbFih?=
 =?us-ascii?Q?TBDtEdl3gyva6YjsUD+StcllJTwaAno0fd5JgEwxeejDz0pT35HpznGhBJAM?=
 =?us-ascii?Q?ew/TWNgwEOyaalml7rfK7iFGttVdbj25Mf1EiAfueXMwdvjfEPKJsGkXsBJl?=
 =?us-ascii?Q?JJBwIyd5rpIuRKWzhasyiyydAO3zK2WFN7LTLsw5mMgHPIrkAVlyyrUQLZ3d?=
 =?us-ascii?Q?P3/V8ShObvaC3QZlfisj5RMOsPYkYQRT5DbCFN8zpvuBqkDgstJK2rJhsWFV?=
 =?us-ascii?Q?p5wVloF5MNSDy7Z/kIHtUcwHVU89BleN6Wp7+onGcirwI8tibGXQn6Sjh8hx?=
 =?us-ascii?Q?PZz2l/bJsmgalqc052OnQq8scMCu1jUvXSilEI7KfO0owjNKVSOCP9OT8xgR?=
 =?us-ascii?Q?MgCk056cS4mEcwK6Yadtb3e0XvG4qocIZ0u+gpYgroWD2aL6RNnlsqZBLpoa?=
 =?us-ascii?Q?rJDpUVHw9ng+NX6Xt8Xr/BUr/GUQoRqu5Jj0A225ejcRj5ELHsKD1NyFMLs7?=
 =?us-ascii?Q?HrfteMi8X6NASRUd66FjzQy8X+YHh5saj1zRST49cemLan9lkaCYyTGcbIUq?=
 =?us-ascii?Q?oyrMcYMqSnrfSAYWfuYRe4JnocKUc7+i3gThxw71+ESWhT5u7VHLnRk8zmSo?=
 =?us-ascii?Q?C7PSlgeEOLsNULvMbV1pD4q8QKUrDNI8+gs3GjHetb0jQrelZ9MTCaZDX9WH?=
 =?us-ascii?Q?Io8iA929RsGB6p93JOudzQQyCuneV5b8515qfwMbdsAZsC83sYx5EhW8PMoA?=
 =?us-ascii?Q?x+nFf7TTSoA5TYIQx++7tDwzxfFFGg3FobU3qgQtbECyM3fgjFS3eZqoDPFd?=
 =?us-ascii?Q?5PQAJDap+D52L2b//mxk2oF0Jr3jj/qkpdFTX4IbFJAZTxoJ90bkngJJB5NA?=
 =?us-ascii?Q?CcrcfPCW6KAcAqNIYZFTIgMYsGnCjufuqytJ8/RMMBTqRB22UfQcOaz9ZouO?=
 =?us-ascii?Q?BzzRgdlzgWlYXJ69vsp1SElhS3MSpX6HHyKIhYkI9cvTKvboySHiAcaw11qU?=
 =?us-ascii?Q?r0DKTlWY12lWMhrg6UdwiJrzNDbG1j2kAi+v4RDVw+uoYOEDp4g8?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73458635-8698-4c58-2f43-08df4a5bc279
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 18:50:07.8341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBmraOYw9PHQ2aMEbWuHKSwAIZw/uW8ZCIEv8IMRlD9U6/6cQJB5V4KJndWF8SLTxovHZ/K/fk+GqLLyj4gnXKOpvgtK4QvS5j27p6WXt6trKn5iFpRBbjPliLiRivCr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12880
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Biju,

On Tue, Nov 24, 2026 at 04:04:48PM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 24 November 2026 15:24
> > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance from the DRM device
> > 
> > Hi Biju,
> > 
> > On Tue, Nov 24, 2026 at 12:51:18PM +0000, Biju Das wrote:
> > >
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 24 November 2026 11:59
> > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > > instance from the DRM device
> > > >
> > > > Hi Biju,
> > > >
> > > > On Tue, Nov 24, 2026 at 09:33:13AM +0000, Biju Das wrote:
> > > > > Hi Tommaso,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > Sent: 24 November 2026 09:21
> > > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the
> > > > > > DU instance from the DRM device
> > > > > >
> > > > > > Hi Biju,
> > > > > > Thanks for your review.
> > > > > >
> > > > > > On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > > > > > > Hi Tommaso,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the
> > > > > > > > DU instance from the DRM device
> > > > > > > >
> > > > > > > > On RZ/G3E two DU instances share a DRM device, which can
> > > > > > > > only be created once both instances have been probed.
> > > > > > > >
> > > > > > > > Split the DU device structure: keep the match data and the
> > > > > > > > registers in a structure allocated with the platform device,
> > > > > > > > and allocate the KMS objects with the DRM device in a new
> > > > > > > > rzg2l_du_instance_init() helper, as they are released
> > > > > > with it.
> > > > > > > >
> > > > > > > > No functional change intended.
> > > > > > > >
> > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > ---
> > > > > > > > v9->v10:
> > > > > > > >  - New patch.
> > > > > > > >
> > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > > > > > > ++++++++++++++------
> > > > > > > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > > > d3cccbdf9012..d102876c07e1 100644
> > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > @@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct
> > > > > > > > device
> > > > > > > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > > > > > > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > > > > > > >
> > > > > > > > +/*
> > > > > > > > +-----------------------------------------------------------
> > > > > > > > +----
> > > > > > > > +----
> > > > > > > > +----
> > > > > > > > +------
> > > > > > > > + * DU instance
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > > > > +				  struct drm_device *ddev) {
> > > > > > > > +	struct rzg2l_du_device *rcdu;
> > > > > > > > +
> > > > > > > > +	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > > > +	if (!rcdu)
> > > > > > > > +		return -ENOMEM;
> > > > > > >
> > > > > > > Why there is duplicate allocation of rcdu? One in probe() and
> > > > > > > here
> > > > > >
> > > > > > The two allocations have different lifetimes.
> > > > > >
> > > > > > The one in rzg2l_du_probe() is tied to the platform device. It
> > > > > > holds what is needed before the DRM device exists and outside of
> > > > > > the component bind (dev, info, mmio, and ddev/is_master for the
> > > > > > master, PM and remove), as on RZ/G3E
> > > > the DRM device is only created once both instances have been probed.
> > > > > >
> > > > > > The one in rzg2l_du_instance_init() holds the KMS objects
> > > > > > (crtcs, vsps, lvds, index). Their drmm cleanup handlers point
> > > > > > into it and run when the DRM device is released, which can
> > > > > > happen after the platform device has been unbound,
> > > > so it has to be allocated with the DRM device.
> > > > >
> > > > > Then there is an issue right, platform unbound will unmap mmio and
> > > > > other data structures it allocated in rzg2l_du_probe()and drm
> > > > > driver is using after that( Use after free Bug)
> > > >
> > > > Mmmm In theory no.
> > > >
> > > > The KMS part keeps its own copy of dev, info and mmio, and its drmm
> > > > cleanup handlers only drop references, they don't access the hardware.
> > >
> > > Can you please make sure these variables set to NULL, after Platform
> > > unbound?
> > 
> > Please correct me if I'm wrong but IMHO this patch keeps the same behaviour as the driver before this
> > series.
> > 
> > Where rcdu is embedded in the DRM device (devm_drm_dev_alloc()) and mmio is devm managed. Setting the
> > pointers to NULL would only turn an invalid access into a NULL dereference no?
> 
> Ack.
> 
> But why you need copy? What preventing to use original allocated rcdu
> in rzg2l_du_modeset_init_du()?

The copy is needed because the two DUs share one DRM device, which can
only be created at bind time, once both instances have been probed.

Before this series, the DRM device was allocated in probe with
devm_drm_dev_alloc(), and rcdu was embedded in it.

Now each instance needs its own structure at probe time (dev, info, mmio),
before the DRM device is allocated with devm_drm_dev_alloc() in the master
bind, so it is allocated with devm_kzalloc(). 

The KMS objects (crtcs[], vsps[]) belong to the shared DRM device, 
so at bind time each instance allocates its own structure for them
with drmm_kzalloc(), released with the DRM device.

Each instance copies its own dev, info and mmio into that structure, as
they are used by the KMS code, e.g. rzg2l_du_crtc_set_display_timing()
(mmio), rzg2l_du_encoders_init() (info) and rzg2l_du_crtc_create()
(dev).

Kind regards,
Tommaso

> 
> Cheers,
> Biju
> 
> 
