Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B39CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB0E10E2E9;
	Tue, 19 May 2026 15:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3pMjt8HF";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CFD10E2E9;
 Tue, 19 May 2026 15:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0zO96LVmwrUjnNFYZvtx3grjzmxKGqJriLWYQ/5qPNiVTbkM4fJbNpoM6KOG+6B9fUgsDvRuHFcDyik2f0My8vqJ0QtOjzfFTPlm0XDLl7uYk6A7KGwXi1jiCd6OLBbX61/n0H6So5mBOtLTyR3Cmct5MPab2NYMQtySU1cexJIovfd74JWszNUiKWFpuK14Sh6H3ruci4aHgoL3Lo7W+jjmAhWibmy704lgpU5e6pSNioBruSVufy9Km/wwo+RDKO9nOal5AF/qtrnngKf3EG3829YjrrIWFW0CXzRkUhC9N2saxAw3hcErO5jrCWl892q9CI0EeYdsVvFko1wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGlRBFfYidSnJCABl/LM7PbrvIO+VremXWdFwRxikYI=;
 b=m4mVBpMWdthQEbHNNyJLW8Osg6NxnFQAesxIG52SCg/210tSbhC9TVIl9KqLwHUGIEnrKLJ8VrP/nkS2JoodODpnGX1SNFsIe0cg2vmmP7vgpnIhcJvhsaiB6uUPmtB6Usu7IjWFLol8c88xavK0OkowxFlDgFB94XexhCLgpcjwv/NLWjIItpt0jwmvaZsQoKtJn8BE4SUOOIS8zKSSW/ptRG3PQlmDQSOGqbDhe6gqI21+r5GxngEXTDjP3B5le0d3BfNNgOw+O1jB4Wo2vLNU3ZggWzujjPt9ij17k9uRp79SnwLvxsHFFRYbX7AUUoZ9/IbnV3WCYuCWgqjzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGlRBFfYidSnJCABl/LM7PbrvIO+VremXWdFwRxikYI=;
 b=3pMjt8HFbiJrpQz/jcSF+j2lFDmb7SE/A/mVnu5TKSleLcETt9b6iShfcxHW+3JzpydnUR3ewanXKxMQN38DP9Up+KzVkanp3+jlzmu50x+bcVdYKC/q4R90RQ6rP+hMrA0pxfaIm4H2Z5x4DyVHf/kUQ0T6unOWY7UUpzt83BU=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by LV9PR12MB9807.namprd12.prod.outlook.com (2603:10b6:408:2eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 15:57:28 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1%3]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 15:57:28 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: Antonio Quartulli <antonio@mandelbit.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Leung,
 Martin" <Martin.Leung@amd.com>, "Pinninti, Bhuvana Chandra"
 <BhuvanaChandra.Pinninti@amd.com>, "Ahmed, Muhammad"
 <Muhammad.Ahmed@amd.com>, "Chen, Karen" <Karen.Chen@amd.com>, "Chen, Leo"
 <Leo.Chen@amd.com>, "Khachatrian, Gaghik" <Gaghik.Khachatrian@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "siqueira@igalia.com" <siqueira@igalia.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "airlied@gmail.com" <airlied@gmail.com>, "Li, Sun peng
 (Leo)" <Sunpeng.Li@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: [RFC] amdgpu: fix compressed buffer config routine waiting time
Thread-Topic: [RFC] amdgpu: fix compressed buffer config routine waiting time
Thread-Index: AQHc554zJM8I82nzKUupHdclU2zkArYVgO6g
Date: Tue, 19 May 2026 15:57:28 +0000
Message-ID: <CH0PR12MB52849BD9E94D9290EFB51B528B002@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20260519144509.2646680-1-antonio@mandelbit.com>
In-Reply-To: <20260519144509.2646680-1-antonio@mandelbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T15:57:27.394Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|LV9PR12MB9807:EE_
x-ms-office365-filtering-correlation-id: cc39c88e-71b3-45da-bd03-08deb5bf53b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|22082099003|56012099003|18002099003|3023799003|38070700021|13003099007|11063799006;
x-microsoft-antispam-message-info: 9d0RlZ+RzWIlW8SSMJLJOZmi2EwuYXHu7t0uoj+5ssjMM8jkqH0V4naLxqomQoMxtwEjsJAhY5Wbx0SZ+rx/jQTolf0jlfxZhiktFbpoHsvgUFw8Et+TrsH18cCgdKVY0ID3Hf/D1LLY0bAyrRVEZ94zPCBb43FsD1Bktzf4wrjsS+osGDt3gtq1mNlcMulIpyDe9+XSZ8jgNY2Rvd0YbLxqCJSOwDkSTnW85GHFlsyyZ+2dF9JAT6ATifEtoFHE2QaRiLmQBPTaXAkcGerkgvB6kT48t/ycIniSlhE9HUfWiEuNh09imzUTCtrQHpCJzSetYIpe4S3A6V3soYjgQnSjfdBqedGju83cKNC/xi2+FeyxfKh/V2th9y2mzZQ1BYuw0MR3rHVeBzMlddzmpuxtua9xJu8wb3/kc2Q8god1gyHlCaD7ECedgZNKpoc0NDYx31Mxt+MI/U1wgmKnQrZ9XjYbavaHebGa83FeWqboXpRc+LkZXix0GHAVilRTG5AEOv+RtVjn/G8Ia6OtS0F18TBTa+BqS2UapBIOnsQxTRRQCwft1dv5vKrZU70bqUhbpwimaFFfxWT5LW3JZ7eBOOD93qUJmeubjF1k+IAfIClRNiLuDUF5myup7AFXc2n5IysnDb3WAd8W/MIi7/lvGJzGgeZVX8mGta9frPx4EdM7yJPf7ZvH0gwtWi2xFL1HqzRYO8osJd73gFGey5Aig2fZjyrihpnfFHF+NYdtP1HIlTuUdsojKuRXa+mc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(22082099003)(56012099003)(18002099003)(3023799003)(38070700021)(13003099007)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MaDuchZXP0NU2QUQvcPmSuWSZ0FN04EyJm5OKTXzSKn4y7IP6a6oVwd07fkx?=
 =?us-ascii?Q?vwwouqeKUP/O/JqEeNoFc7C4BVodjA3/RT5kNaVlBQZGPzlwtCYMLxeYagyn?=
 =?us-ascii?Q?k2GqHkinZy2nAhRSp5CrD/Z6gvhE0O1qlXWTVHpCtVfNW4Kx0zfb7XZBLx5v?=
 =?us-ascii?Q?BZh65f+mDs8VFE18uWwY0/95KodCYPwD5DFxQBAmoS2QMMwVjrPa+dhkuBf8?=
 =?us-ascii?Q?CIbjYAmy/gwVi2MUGbqpE358G272/EV4JtNIbjJaKeGK0mKrwKpvqnlp1h9V?=
 =?us-ascii?Q?mtEBWlpdOnzJ+sO2qhH+3QjSiEHFl4hJqYL0udIBCMUqEnct/P2GJyKCai8/?=
 =?us-ascii?Q?STc+/pN9g/LEGhXp9o/8iZODNBTMX6G6l9TPa/o4Ula+2d9eq2LA4gtzjmae?=
 =?us-ascii?Q?CdaxgRtvaw8hrRWDRSNGAW6oNCjGRUf+4KzyrJ0W2yrrJU42y4VaQAvu/7SD?=
 =?us-ascii?Q?Y/aZrIkWXVfjLBTbHHtBUeDTBvtZV4iisFAF9ylzLaVZJIRSCePBJQEJHLyP?=
 =?us-ascii?Q?qqdT2lMb0musAYPUjUsAA6EOuazGI59thEccxUBPQuDpINMj/3zhrJdN68gJ?=
 =?us-ascii?Q?HXQuhBerLSKExTp36ZQWJ763vg8Jroc9ptfn7skR7PSzCm9upugJksKNKuvc?=
 =?us-ascii?Q?r41nLr0ZTdv6OGSBCqQXCzTucJgkm15oUmrc5G1VO9fWY50Jexj/bZj4ZGKD?=
 =?us-ascii?Q?4KJxAHn+JS5daYytYpqNrrFvB0KLMk9cr7USoMIBAogynOfrGrt2o9PwdD1X?=
 =?us-ascii?Q?aB7qCfsCuWe/gkpDgu2Ao0BUNB6gp/e3r/r6515pNgM69GVBFTfv7tQ3C2RN?=
 =?us-ascii?Q?RrmRi8KmXQ34bU3N9BtTlb1B3RwYJXm99j/DIAO7XAnczNwLLs2qWUOStoY8?=
 =?us-ascii?Q?XTcDzxWTklFLgILB41oZFvvpza0U/0ZUy8DtoKu89AM0r5NQ6NDG2twk/rAW?=
 =?us-ascii?Q?jSGDVBSl1MhiS/qekVKH9MpPnARrjxodBsGPSvWzZkwZHFq8q+Pmt31ojc4S?=
 =?us-ascii?Q?P7Vg1Pa0mTrme7h2GLUwCKhQRUFKcKYhi5dK2DMJuu8+a35z5zqsX7JahTu3?=
 =?us-ascii?Q?MOjSHBy6ylKaRtK4ZH91DCPkqD9TYJKaFgQq0aIeKlgvdcVtrxnNKSx/3jri?=
 =?us-ascii?Q?J1uc6p0m4bZs06MzgOa4grOS9y1WQOfJqbta3eHJjNaYXOMFSgCqIrHHG5y7?=
 =?us-ascii?Q?Sbu3ndeSAXWBYvsjxXwBCZaWEaz3kEWviP30CH+3TqL4C6u2fm8FmM35iC16?=
 =?us-ascii?Q?viX0llFFZvpj+0PFl2jM2ai+bt6ocFW3Ho1xrEUgDCmcqa1U1F3GfTg8qpqA?=
 =?us-ascii?Q?hHzmikACeRjy2Mt3rRCht1O4ocA2cU3nnuVMbKM/2Z14nxNrsWn3Gon4GSLx?=
 =?us-ascii?Q?59ELJfapzXaPABTN590TJo1/Dqc1Lh/mqRsMBdXY1o4FcOFL2cYBReFn7NQQ?=
 =?us-ascii?Q?kSgjDR27iJtvHWH8LbfPqvi1SrIJ496s3PVQAyIpRylXAXmxL+DU4Kp6cELF?=
 =?us-ascii?Q?1uxr6xZco6uvnLv8LdfzW5HEj7hRKWPYP+YjL+fXvl2es+UAuvplPECZGEIq?=
 =?us-ascii?Q?Sv3cbtEx98NDb1cf2FhW5feHkI2SM7WlbJeo8Gkbayrj3CbkCXMYNWGjQ3xw?=
 =?us-ascii?Q?9r1u/ZhtQxUZlGgQi76EAjphjSFH0GnDggMZ9+/3G0TCj/Kw8xE6GEIEhA2N?=
 =?us-ascii?Q?YZohJIt8GEqXYKnVTHnniriT2qFKs8N9V6JSBEBVnRSw6bcr?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52849BD9E94D9290EFB51B528B002CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc39c88e-71b3-45da-bd03-08deb5bf53b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 15:57:28.0787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCDhhZ52yyrnKTZRAjD7Gwcc1Bv8UxmuWjzPrzv2wGYEFMCslGfgxaX4nGZ3+hqx6AAdp4MXDUrKBBZXPD/nSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9807
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

--_000_CH0PR12MB52849BD9E94D9290EFB51B528B002CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Antonio,

Thanks for the patch. We'll add it to our weekly cycle for testing.

--

Regards,
Jay
________________________________
From: Antonio Quartulli <antonio@mandelbit.com>
Sent: Tuesday, May 19, 2026 10:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: antonio@mandelbit.com <antonio@mandelbit.com>; linux-kernel@vger.kernel=
.org <linux-kernel@vger.kernel.org>; dri-devel@lists.freedesktop.org <dri-d=
evel@lists.freedesktop.org>; Leung, Martin <Martin.Leung@amd.com>; Pinninti=
, Bhuvana Chandra <BhuvanaChandra.Pinninti@amd.com>; Pillai, Aurabindo <Aur=
abindo.Pillai@amd.com>; Ahmed, Muhammad <Muhammad.Ahmed@amd.com>; Chen, Kar=
en <Karen.Chen@amd.com>; Chen, Leo <Leo.Chen@amd.com>; Khachatrian, Gaghik =
<Gaghik.Khachatrian@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Way=
ne.Lin@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Koenig=
, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; siqueira@igalia.com <siqueira@igalia.com>; simona@ffwll.ch <si=
mona@ffwll.ch>; airlied@gmail.com <airlied@gmail.com>; Li, Sun peng (Leo) <=
Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: [RFC] amdgpu: fix compressed buffer config routine waiting time

Starting with commit 592c5b80110d5 ("drm/amd/display: Migrate HUBBUB regist=
er access from hwseq to hubbub component.")
the amdgpu driver is reporting the following WARNING in the kernel log
during boot time:

[   15.464476] amdgpu 0000:0c:00.0: [drm] REG_WAIT timeout 1us * 100 tries =
- dcn31_program_compbuf_size line:141
[   15.464522] ------------[ cut here ]------------
[   15.464523] !(generic_reg_get(hubbub2->base.ctx, hubbub2->regs->DCHUBBUB=
_COMPBUF_CTRL, hubbub2->shifts->CONFIG_ERROR, hubbub2->masks->CONFIG_ERROR,=
 &compbuf_size_segments) && !compbuf_size_segments)
[   15.464524] WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/hubbub/dcn=
31/dcn31_hubbub.c:151 at dcn31_program_compbuf_size+0x20e/0x220 [amdgpu], C=
PU#2: kworker/2:2/184
[   15.464906] Workqueue: events drm_mode_rmfb_work_fn
[   15.464910] RIP: 0010:dcn31_program_compbuf_size+0x20e/0x220 [amdgpu]
[   15.465200]  <TASK>
[   15.465202]  dcn20_optimize_bandwidth+0x110/0x210 [amdgpu]
[   15.465556]  dc_commit_state_no_check+0x14ff/0x18a0 [amdgpu]
[   15.465925]  dc_commit_streams+0x471/0x640 [amdgpu]
[   15.466252]  amdgpu_dm_atomic_commit_tail+0x903/0x4430 [amdgpu]
[   15.467401]  commit_tail+0x242/0x2e0
[   15.467405]  drm_atomic_helper_commit+0x28b/0x2a0
[   15.467407]  drm_atomic_commit+0xc3/0xf0
[   15.467416]  drm_mode_rmfb_work_fn+0x85/0xb0
[   15.467436]  ret_from_fork_asm+0x1a/0x30
[   15.467441]  </TASK>

After boot this results in unstable video output, specifically after
resuming from screen sleep. The video may not come back at all
or may come up partly messed up.

This problem seems to affect various people on AMD iGPU, as discussed
on the related GitHub issue.

Giuseppe Ranieri digged up the issue and suggested the proposed code
change.

There was also a previous report on the amd-gfx ml (see related link below)
but it got nowhere.

By looking at the offending commit I am not truly able to understand why
it is breaking. Hence I am posting this patch as RFC only.

What I can say is that this fix has been solid on my platform running
7.1.0-rc3 with this patch.

I am on:
Gigabyte Technology Co., Ltd. B850M DS3H/B850M DS3H + AMD Ryzen 9 9950X

Fixes: 592c5b80110d5 ("drm/amd/display: Migrate HUBBUB register access from=
 hwseq to hubbub component.")
Link: https://github.com/CachyOS/linux-cachyos/issues/810
Link: https://lore.kernel.org/amd-gfx/20260316094232.6bb6f0bf@schienar/
Suggested-by: Giuseppe Ranieri
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 .../gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/d=
rivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 3c298192f3596..9dc1db4524500 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -138,10 +138,10 @@ static void dcn31_program_compbuf_size(struct hubbub =
*hubbub, unsigned int compb

         if (safe_to_increase || compbuf_size_segments <=3D hubbub2->compbu=
f_size_segments) {
                 if (compbuf_size_segments > hubbub2->compbuf_size_segments=
) {
-                       REG_WAIT(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, hub=
bub2->det0_size, 1, 100);
-                       REG_WAIT(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, hub=
bub2->det1_size, 1, 100);
-                       REG_WAIT(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, hub=
bub2->det2_size, 1, 100);
-                       REG_WAIT(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, hub=
bub2->det3_size, 1, 100);
+                       dcn31_wait_for_det_apply(hubbub, 0);
+                       dcn31_wait_for_det_apply(hubbub, 1);
+                       dcn31_wait_for_det_apply(hubbub, 2);
+                       dcn31_wait_for_det_apply(hubbub, 3);
                 }
                 /* Should never be hit, if it is we have an erroneous hw c=
onfig*/
                 ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->=
det2_size
--
2.53.0


--_000_CH0PR12MB52849BD9E94D9290EFB51B528B002CH0PR12MB5284namp_
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
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Hi Antonio,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for the patch. We'll add it to our weekly cycle for testing.</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Antonio Quartulli &lt=
;antonio@mandelbit.com&gt;<br>
<b>Sent:</b> Tuesday, May 19, 2026 10:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> antonio@mandelbit.com &lt;antonio@mandelbit.com&gt;; linux-kerne=
l@vger.kernel.org &lt;linux-kernel@vger.kernel.org&gt;; dri-devel@lists.fre=
edesktop.org &lt;dri-devel@lists.freedesktop.org&gt;; Leung, Martin &lt;Mar=
tin.Leung@amd.com&gt;; Pinninti, Bhuvana Chandra &lt;BhuvanaChandra.Pinnint=
i@amd.com&gt;;
 Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Ahmed, Muhammad &lt;Mu=
hammad.Ahmed@amd.com&gt;; Chen, Karen &lt;Karen.Chen@amd.com&gt;; Chen, Leo=
 &lt;Leo.Chen@amd.com&gt;; Khachatrian, Gaghik &lt;Gaghik.Khachatrian@amd.c=
om&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.co=
m&gt;;
 Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt;; siqueira@igalia.com &lt;siqueira@igalia.com&gt;; simona@ffwl=
l.ch &lt;simona@ffwll.ch&gt;; airlied@gmail.com &lt;airlied@gmail.com&gt;;
 Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.W=
entland@amd.com&gt;<br>
<b>Subject:</b> [RFC] amdgpu: fix compressed buffer config routine waiting =
time</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Starting with commit 592c5b80110d5 (&quot;drm/amd/=
display: Migrate HUBBUB register access from hwseq to hubbub component.&quo=
t;)<br>
the amdgpu driver is reporting the following WARNING in the kernel log<br>
during boot time:<br>
<br>
[&nbsp;&nbsp; 15.464476] amdgpu 0000:0c:00.0: [drm] REG_WAIT timeout 1us * =
100 tries - dcn31_program_compbuf_size line:141<br>
[&nbsp;&nbsp; 15.464522] ------------[ cut here ]------------<br>
[&nbsp;&nbsp; 15.464523] !(generic_reg_get(hubbub2-&gt;base.ctx, hubbub2-&g=
t;regs-&gt;DCHUBBUB_COMPBUF_CTRL, hubbub2-&gt;shifts-&gt;CONFIG_ERROR, hubb=
ub2-&gt;masks-&gt;CONFIG_ERROR, &amp;compbuf_size_segments) &amp;&amp; !com=
pbuf_size_segments)<br>
[&nbsp;&nbsp; 15.464524] WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/=
hubbub/dcn31/dcn31_hubbub.c:151 at dcn31_program_compbuf_size+0x20e/0x220 [=
amdgpu], CPU#2: kworker/2:2/184<br>
[&nbsp;&nbsp; 15.464906] Workqueue: events drm_mode_rmfb_work_fn<br>
[&nbsp;&nbsp; 15.464910] RIP: 0010:dcn31_program_compbuf_size+0x20e/0x220 [=
amdgpu]<br>
[&nbsp;&nbsp; 15.465200]&nbsp; &lt;TASK&gt;<br>
[&nbsp;&nbsp; 15.465202]&nbsp; dcn20_optimize_bandwidth+0x110/0x210 [amdgpu=
]<br>
[&nbsp;&nbsp; 15.465556]&nbsp; dc_commit_state_no_check+0x14ff/0x18a0 [amdg=
pu]<br>
[&nbsp;&nbsp; 15.465925]&nbsp; dc_commit_streams+0x471/0x640 [amdgpu]<br>
[&nbsp;&nbsp; 15.466252]&nbsp; amdgpu_dm_atomic_commit_tail+0x903/0x4430 [a=
mdgpu]<br>
[&nbsp;&nbsp; 15.467401]&nbsp; commit_tail+0x242/0x2e0<br>
[&nbsp;&nbsp; 15.467405]&nbsp; drm_atomic_helper_commit+0x28b/0x2a0<br>
[&nbsp;&nbsp; 15.467407]&nbsp; drm_atomic_commit+0xc3/0xf0<br>
[&nbsp;&nbsp; 15.467416]&nbsp; drm_mode_rmfb_work_fn+0x85/0xb0<br>
[&nbsp;&nbsp; 15.467436]&nbsp; ret_from_fork_asm+0x1a/0x30<br>
[&nbsp;&nbsp; 15.467441]&nbsp; &lt;/TASK&gt;<br>
<br>
After boot this results in unstable video output, specifically after<br>
resuming from screen sleep. The video may not come back at all<br>
or may come up partly messed up.<br>
<br>
This problem seems to affect various people on AMD iGPU, as discussed<br>
on the related GitHub issue.<br>
<br>
Giuseppe Ranieri digged up the issue and suggested the proposed code<br>
change.<br>
<br>
There was also a previous report on the amd-gfx ml (see related link below)=
<br>
but it got nowhere.<br>
<br>
By looking at the offending commit I am not truly able to understand why<br=
>
it is breaking. Hence I am posting this patch as RFC only.<br>
<br>
What I can say is that this fix has been solid on my platform running<br>
7.1.0-rc3 with this patch.<br>
<br>
I am on:<br>
Gigabyte Technology Co., Ltd. B850M DS3H/B850M DS3H + AMD Ryzen 9 9950X<br>
<br>
Fixes: 592c5b80110d5 (&quot;drm/amd/display: Migrate HUBBUB register access=
 from hwseq to hubbub component.&quot;)<br>
Link: <a href=3D"https://github.com/CachyOS/linux-cachyos/issues/810">https=
://github.com/CachyOS/linux-cachyos/issues/810</a><br>
Link: <a href=3D"https://lore.kernel.org/amd-gfx/20260316094232.6bb6f0bf@sc=
hienar/">
https://lore.kernel.org/amd-gfx/20260316094232.6bb6f0bf@schienar/</a><br>
Suggested-by: Giuseppe Ranieri<br>
Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c&nbsp;&nbsp;&nb=
sp; | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/d=
rivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c<br>
index 3c298192f3596..9dc1db4524500 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c<br>
@@ -138,10 +138,10 @@ static void dcn31_program_compbuf_size(struct hubbub =
*hubbub, unsigned int compb<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (safe_to_increase || co=
mpbuf_size_segments &lt;=3D hubbub2-&gt;compbuf_size_segments) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (compbuf_size_segments &gt; hubbub2-&gt;compbuf_si=
ze_segments) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WAIT(DCHUBBU=
B_DET0_CTRL, DET0_SIZE_CURRENT, hubbub2-&gt;det0_size, 1, 100);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WAIT(DCHUBBU=
B_DET1_CTRL, DET1_SIZE_CURRENT, hubbub2-&gt;det1_size, 1, 100);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WAIT(DCHUBBU=
B_DET2_CTRL, DET2_SIZE_CURRENT, hubbub2-&gt;det2_size, 1, 100);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WAIT(DCHUBBU=
B_DET3_CTRL, DET3_SIZE_CURRENT, hubbub2-&gt;det3_size, 1, 100);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn31_wait_for_d=
et_apply(hubbub, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn31_wait_for_d=
et_apply(hubbub, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn31_wait_for_d=
et_apply(hubbub, 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn31_wait_for_d=
et_apply(hubbub, 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Should never be hit, if it is we have an erroneous=
 hw config*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ASSERT(hubbub2-&gt;det0_size + hubbub2-&gt;det1_size =
+ hubbub2-&gt;det2_size<br>
-- <br>
2.53.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB52849BD9E94D9290EFB51B528B002CH0PR12MB5284namp_--
