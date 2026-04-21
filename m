Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2373F588C9
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F395410E738;
	Tue, 21 Apr 2026 05:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mzEoPKQV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012042.outbound.protection.outlook.com
 [40.93.195.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F125010E738
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 05:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOv+MIVbmnS+QD3ZQsPl1fsMAHcLhUVxuT8h+ozmLVB9BOrgii56HgHqJf6xUzD92HI1OU5X5MS8IBK2eyud29G+3rHiQ9y9dkwIjGay0mqih1BuCPaooriF1fmf4ysU50qGHmAKXb4EVzOwzpSrs2+CLb7QOp+4Q/k7dIRxRvdetjYPD8fHjuYOF0yoOIy5osco75xUwKxhqJlhaMqZ3qh1s74A4dgTlvWRaTor/Kz8QA0UDuoTfN1J6OOqFREaSPxpL/L/wn08j5CaWVqbfeAQBhW/suodH1lGreAAGNaJYFJ6lEp6ng7/GpNa6m/BQcdyrWGlbKNk2IeIuqNk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq8iZMmNU6XNfaGwumj91828A7JOVGmriR05mrMtk0U=;
 b=THymkiPdswHJY0680ErJQeaSqhtlmsIa9C5GmTsOFyXRiYu6zBXPdG/CqE/n63kazQlzpPSKH5Q2dbVbcoXo0lh2ngYWL0+Jf+Smi1dXldeoMw/wtujsejnQl0EuTRHgzP8IfiW4WyucQ/CEvo59jK5kNLQjxa2f67FcpAdncFf2OOHjfaqah4ziBkE3HQ3OcXKAp7ukzJ0QJeyI+atlTfkaBXz1CtufjLo6vemfZTJEVax5ibyalyJaEsNS9nhEqP4HtTKZOzBFr0dF81UqsFmVwJB2f0ioa+UfAZsWkf3jl3r5RtNmFM7th6ByTIHy6fCp2rQfkhgiZTpr5rDCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq8iZMmNU6XNfaGwumj91828A7JOVGmriR05mrMtk0U=;
 b=mzEoPKQVPct2UeQ49/KicJTYpDwKEPwv9GAZrjir/LUkt2wRxH5j/8m3o+so7jnZiaij0EfSXUgoKlDXCNmSCOhBBG+k9R86p1xZCDne+J62O+uYATyLJd2yIz5CHgDCoLPjrMSpwt+K3PrM8mJIGWxhyYGprqgXlleIDwlEhUQ=
Received: from IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 05:42:30 +0000
Received: from IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2]) by IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 05:42:30 +0000
From: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
To: Phillip Susi <phill@thesusis.net>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: Regression from: drm/amd/display: Move FPU Guards From DML To DC
 - Part 1
Thread-Topic: Regression from: drm/amd/display: Move FPU Guards From DML To DC
 - Part 1
Thread-Index: AQHc0Rp88I68wi2kNEySCjuhtVvSG7XpAQYO
Date: Tue, 21 Apr 2026 05:42:29 +0000
Message-ID: <IA1PR12MB63078F14C8F3B76619725A9AF82C2@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <87cxztkz7v.fsf@vps.thesusis.net>
In-Reply-To: <87cxztkz7v.fsf@vps.thesusis.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-21T05:42:29.555Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6307:EE_|BL1PR12MB5849:EE_
x-ms-office365-filtering-correlation-id: 7e325862-15b0-409a-69e5-08de9f68c724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: dfVLXY6H2UVTslVD2v2qPxKxeguVzPY3e9j4Hm/OSTdRgrinO++raFYZKGRr3jNGLTLw3lgmSb+84GAFlRD4gR64hQPSCn3QWksUXeSUA243uJM1fpoZxC4wI8Mu2P97RV3CHvmrqS9B4AvLJ+qvRRWxIsl9O86q4Uv8dOf440rTvcTgvjzUH96fKuO/W6pC2ZDrsgUC3T9WQTmQMbmpwJ82PzOxCNKYMYCQpnJ5Cx2SWwwvezzSvETWdZAwWeUPRf65RLL3cye1iFxODx+7Q+KGmrBunSKWSi9ClVitYJyimLnFQfg1V4JIbzKID+agVTCerDbzmaP36OqsGEP4MunCTA1cOI9ulga0NDm+X9vZGH9mYQqJMy1z/g74bYQw7lAXMNZFzLDmhcWOG/ZvgTW6nIIuYAwmy+EOh5pWcThIDDJlXRp0kv/iyjIW/OklE0GkeoE8YdoOAmyTtcFwHhHYgMIcP3NjV21+GoP6/5OVE8b4TcmJ0b5dShaFi6tWkmOKOQUwRUrxWySG+RgbYj4c0At/3SGykNBV2dS6jJF1afTdYP9Gvsbm2gJI9IWnReWzjSq3pN936IS92ghawqJoQ7og2bvC9xyES3J5DKoiLs3fFVhDZP0TShJc7z3iqzc9HVsQLNP+/mucaZRNIBBjnNiNY+riKTD4Z8FT2Qmg8qc7JofZg8DgTvz1wF90oUbCPpCfHJP/cyEBk6lNfM0iG1nYM7z/+8MeT6/suOHzBzXtAgjnOaSZZDynQkhM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g4OE/rcplV5mIu7CwL0NtvBgwBxbeFfIETO3djg3lraJUWsWnKtXcC7Lbd?=
 =?iso-8859-1?Q?ubacaF3AMlXukwg/joo2zWInKN7xwZIA9myEEtO9htYFxnvttVoA0yuduv?=
 =?iso-8859-1?Q?8pla8i7ND6NZ6WcyOsu35U8h18/SQ5k5kVSD/nzvPnfKc+2cF0Nc6gv0yj?=
 =?iso-8859-1?Q?KYMd0kUoHNOIfGWAjcCwb3ve4dVabmXTxFQnSBH9uW0oC3Vigy8r0iL9sQ?=
 =?iso-8859-1?Q?gUYfUxGuG7pCeeEcHIURmDpm/zLWXntP4ZOMhLfiiTlBkDDlQH7qiH5JJK?=
 =?iso-8859-1?Q?bvIgby3MtQHsRHj5FI/Kw6/fd2T2Xgp+9bvMrxFnw2dqlkBor8E9fILBmb?=
 =?iso-8859-1?Q?oUItbDvWk/c04jojPyLK3wfe9D1ETkktMPNlMCQ/E/Li8hLu3+90z/vXgl?=
 =?iso-8859-1?Q?H9rrQfWi/8lMP2pkW53gauF/Pl0oz+AiM3OFpy2b4OAGHdugqO6c9Ng03m?=
 =?iso-8859-1?Q?q4pbcP8DL58dCq2hdlBMXavYhcmHi0DXdlJz4vnmDs15rNd7aJGp45/YIi?=
 =?iso-8859-1?Q?4lHemWTb0fHU0i9miqsEQ14AVXaNBpBH9N/qfUFG8D5yMrPavzIEtnIvUh?=
 =?iso-8859-1?Q?2STlpGsqpFzK1t3hlAAqzjPr10cpKHzL4ixQir3qvKUIZ5q/c3VMhf/jnu?=
 =?iso-8859-1?Q?RiSEkSQgJpsE5SZQle5XHwgIdrLN8ZZMs9NMF+DDOb54JIypJNdnsCG4F2?=
 =?iso-8859-1?Q?+xDd2ohciPSDXLrQCYNVCEJRoHVxs51s7BMKLg6QjqMVII47IFLmEx1O+X?=
 =?iso-8859-1?Q?ZimlxNk9FGPZ+aYtRqSIkCVO2u2C5hpOi+BhAt6/CnushsHrhQ76LcouWA?=
 =?iso-8859-1?Q?hfCuj6GLnAV4QcTtFZKXoKcGgAdU1Ce1/qmi/V0HnyfLOQ91lAp9uVnh2p?=
 =?iso-8859-1?Q?s/R0NqheSFeArvsnIoLcNgySGX1jlTpJCr/p9Cbwxxi7DQwwymeCMF8RBV?=
 =?iso-8859-1?Q?8RObAd90bYU4jQhLGL9N+ap0gEfNDRYYZUFfOTianBCZBnQIT1S5vHi2wU?=
 =?iso-8859-1?Q?USC5yHqdN1gEyEkngFn/dVmnSt5ESA9CTdGaTdlJ8z/U8AbxNzc4SNatay?=
 =?iso-8859-1?Q?T2Gs4vaqGyIQ0KM0LmwHKF/Dc+Ltbkq3+o9qC9ACy0pj0B99/VxrRZ3jFE?=
 =?iso-8859-1?Q?mqgtZrptSsmbak4FqYf41/j+Ep2an8Cjq1ASlMBrewJ0OJVZBdkvGaP2VB?=
 =?iso-8859-1?Q?yzoFuwp0rUCDbhZt06o25R5Wv17313GmVtED1FZOwpprKFGyANhRT8kN2Z?=
 =?iso-8859-1?Q?U/4S7mcN+7Pj4XYHT/LH3uqhnIFB31OMSRaEnyQOJ28yuBHvmElG5tEzt7?=
 =?iso-8859-1?Q?OvKlFdafOTH/XceBfy8U6MgEHzAf+PF07bLKgY87yKEvOh8NIKH0dk+OC0?=
 =?iso-8859-1?Q?t9BgZOnmQ/anP6Wt1jEGKAMiVuEfNsV0ivafrp//ErGiaEl6MYw+dFixh1?=
 =?iso-8859-1?Q?7Q8H6E/qIbnh74Nih3TaA5ljVSneXeEh3hxu3fed5ifWYSqWz7otI7MYEv?=
 =?iso-8859-1?Q?GTce0khX8RSNn3xhFQhUrY/vlyNWp9yFoQXD42sTWJSzoYpadLokJBkGM0?=
 =?iso-8859-1?Q?g4TWcNDXB5ilYnUqFKdaNsAcE/R/71ZgP5Bj3f1FejJ5q5TW731TGdVY28?=
 =?iso-8859-1?Q?PRRwAYtuDCzlECe4T0fxIlXFYQodj7p8VEIxG8YYa99MxXyvpHX1UMxnRv?=
 =?iso-8859-1?Q?TUyPB6Qm5dykA4GkEYsJVaejcJeEytCFl7IhC2pYGj/waOIkryd6GKdltC?=
 =?iso-8859-1?Q?TofyFUQ31hEHpYcpu06s6iJuv8IH0xzctWA2AODCzczcDa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6307.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e325862-15b0-409a-69e5-08de9f68c724
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 05:42:29.9254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZbCC+GevNAQd4ryJRt3udeDEP55dvR0T82THmwBoV0hLPsNFyysT4eV9uG9mpQfgVN6uwUn0Xk25TA2ojBbDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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

From Phillip Susi<phill@thesusis.net>=0A=
>=0A=
> This commit:=0A=
> =0A=
> commit 3539437f354bd24c98928a80d4db3a23fa2a7b19 (HEAD)=0A=
> Author: Rafal Ostrowski <rafal.ostrowski@amd.com>=0A=
> Date:   Tue Feb 24 15:36:09 2026 +0100=0A=
> =0A=
>     drm/amd/display: Move FPU Guards From DML To DC - Part 1=0A=
> =0A=
>     [Why]=0A=
>     FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code t=
hat=0A=
>     can manipulates floats. To do this properly, the FPU guards must be u=
sed=0A=
>     in a file that is not compiled as a FPU unit. If the guards are used =
in=0A=
>     a file that is a FPU unit, other sections in the file that aren't gua=
rded=0A=
>     may be end up being compiled to use FPU operations.=0A=
> =0A=
>     [How]=0A=
>     Added DC_FP_START and DC_FP_END to DC functions that call DML functio=
ns=0A=
>     using FPU.=0A=
> =0A=
>     Reviewed-by: Dillon Varone <dillon.varone@amd.com>=0A=
>     Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>=0A=
>     Signed-off-by: Alex Hung <alex.hung@amd.com>=0A=
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>=0A=
> =0A=
> Started causing this warning for me on every boot:=0A=
> =0A=
> ------------[ cut here ]------------=0A=
> WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58 at d=
c_assert_fp_enabled+0x14/0x20 [amdgpu], CPU#13: (udev-worker)/267=0A=
> Modules linked in: hid_generic usbhid hid amdgpu(+) drm_buddy amdxcp drm_=
panel_backlight_quirks gpu_sched drm_ttm_helper sr_mod ttm drm_client_lib c=
drom sd_mod drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper xh=
ci_pci dm_mod sp5100_tco r8169 >=0A=
> CPU: 13 UID: 0 PID: 267 Comm: (udev-worker) Not tainted 7.0.0-rc4+ #142 P=
REEMPTLAZY=0A=
> Hardware name: ASRock B650E Taichi Lite/B650E Taichi Lite, BIOS 3.06 07/2=
6/2024=0A=
> RIP: 0010:dc_assert_fp_enabled+0x14/0x20 [amdgpu]=0A=
> Code: 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0=
f 1f 40 d6 65 8b 05 0d b9 88 ea 85 c0 7e 05 c3 cc cc cc cc <0f> 0b c3 cc cc=
 cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90=0A=
> RSP: 0018:ffffae440099b5f8 EFLAGS: 00010246=0A=
> RAX: 0000000000000000 RBX: ffff922168000000 RCX: 0000000000000000=0A=
> RDX: ffff9221617c4c00 RSI: ffffffffc12acee0 RDI: ffff922168000000=0A=
> RBP: ffffae440099b618 R08: 000000001faa2800 R09: 000000000000000d=0A=
> R10: ffff92215d6b0108 R11: ffff9221429d7a40 R12: ffffffffc12acee0=0A=
> R13: ffff92214fcaa800 R14: ffff922161600010 R15: ffff922161600000=0A=
> FS:  00007f3485b309c0(0000) GS:ffff922ca2d3e000(0000) knlGS:0000000000000=
000=0A=
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
> CR2: 000055b1d93d8000 CR3: 0000000117541000 CR4: 0000000000750ef0=0A=
> PKRU: 55555554=0A=
> Call Trace:=0A=
>  <TASK>=0A=
>  dcn315_update_bw_bounding_box+0x1f/0x210 [amdgpu]=0A=
>  dc_create+0x286/0x620 [amdgpu]=0A=
>  amdgpu_dm_init+0x2d8/0x4e0 [amdgpu]=0A=
>  ? prb_read_valid+0x1b/0x30=0A=
>  ? console_unlock+0xa3/0x140=0A=
>  ? preempt_count_add+0x4b/0xa0=0A=
>  ? __wake_up_klogd.part.0+0x56/0x80=0A=
>  ? vprintk_emit+0x273/0x330=0A=
>  dm_hw_init+0x1b/0x90 [amdgpu]=0A=
>  amdgpu_device_init.cold+0xfe0/0x1d89 [amdgpu]=0A=
>  ? _raw_spin_lock_irqsave+0x1b/0x50=0A=
>  ? pci_conf1_read+0xb3/0x100=0A=
>  ? pci_bus_read_config_word+0x4c/0x80=0A=
>  amdgpu_driver_load_kms+0x19/0x80 [amdgpu]=0A=
>  amdgpu_pci_probe+0x215/0x430 [amdgpu]=0A=
>  local_pci_probe+0x41/0x90=0A=
>  pci_device_probe+0xd7/0x2a0=0A=
>  ? sysfs_do_create_link_sd+0x6e/0xe0=0A=
>  really_probe+0xde/0x380=0A=
>  ? _raw_spin_unlock_irq+0x17/0x40=0A=
>  ? __pfx___driver_attach+0x10/0x10=0A=
>  __driver_probe_device+0x78/0x120=0A=
>  driver_probe_device+0x1f/0xa0=0A=
>  __driver_attach+0xba/0x1f0=0A=
>  bus_for_each_dev+0x7d/0xd0=0A=
>  bus_add_driver+0x11f/0x200=0A=
>  driver_register+0x72/0xd0=0A=
>  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]=0A=
>  do_one_initcall+0x47/0x310=0A=
>  ? __kmalloc_cache_noprof+0x142/0x470=0A=
>  do_init_module+0x60/0x240=0A=
>  init_module_from_file+0xce/0xf0=0A=
>  idempotent_init_module+0xff/0x2f0=0A=
>  __x64_sys_finit_module+0x71/0xe0=0A=
>  do_syscall_64+0x127/0x650=0A=
>  ? __check_object_size+0x1b6/0x250=0A=
>  ? kmem_cache_free+0x16c/0x3f0=0A=
>  ? do_sys_openat2+0x83/0xd0=0A=
>  ? fpregs_assert_state_consistent+0x34/0x60=0A=
>  ? do_syscall_64+0x160/0x650=0A=
>  ? irqentry_exit+0x97/0x560=0A=
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e=0A=
> RIP: 0033:0x7f348668d7b9=0A=
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48=0A=
> RSP: 002b:00007ffd1436add8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139=0A=
> RAX: ffffffffffffffda RBX: 000055b1d93acd90 RCX: 00007f348668d7b9=0A=
> RDX: 0000000000000000 RSI: 00007f3484e0c44d RDI: 0000000000000020=0A=
> RBP: 0000000000000000 R08: 0000000000000000 R09: 000055b1d9389cb0=0A=
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3484e0c44d=0A=
> R13: 0000000000020000 R14: 000055b1d93ac6f0 R15: 0000000000000000=0A=
>  </TASK>=0A=
> ---[ end trace 0000000000000000 ]---=0A=
>=0A=
=0A=
Hi Phillip,=0A=
=0A=
Sorry for problems that occured on your platform.=0A=
This issue is fixed as part of this change: https://patchwork.freedesktop.o=
rg/patch/718415/=0A=
Please retest using mentioned patch. If it works correctly, please let me k=
now.=0A=
If problem still occurs please share me details and I will work on resolvin=
g it.=0A=
=0A=
Kind Regards,=0A=
Rafal Ostrowski=
