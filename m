Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69866C624A4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BA010E360;
	Tue,  1 Sep 2026 03:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bnHSEERq";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8922210E360
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 03:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2W2keCGRkbAtvTTXxs/jc2ML+9R4vqsYxJkxORoa3JgI4ntPdouk8N78yfSSqfXKGl6V9qoUI2MVrEFpneTJFCZ+z9yb/4MlANoSlUwteQ7i5hKNYHXqZ7J2YT+mrdSCG/yORE8h8Rsw2hWTxke48bpNL08+Q5TTJFLypCYKWBK28k5p9sBtQSS2oACOY0VcV1QiCAFrPNLeNkNiHxMY0lum0OQxTR5Wu3/fTBA+Gf7R1fn6g/CNXBRsohqekNvULo7a7s8X4QNZCNi7s0mKxwdLO1djLlccxn+DKWQFLQGlsI9CHeGfqIuog2Yfj8E1tAML6Xw9m4QgVVA1H6kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUxVAsooR+2RFdhzhFi4V4gvOmewhBSgNTPp3whGNQM=;
 b=dwTv4dIepEffrOfSn9DJis8wLyvq2yyKMKARL9/OaEJ28lM/jyps46irxToHnEXYh4OTcrS3FoLRObz1kcMRsNC7ATic4ITZaFVl2okcceB62j0xbplmgZ4EN77op8CrZw5jnHM9B5T3GuR/anVl6+KR8nDkDaUWcM1v2p/qZWCS8aqH5wwygkpRkedHiauc6+5vsIHkwAQoFtMHCxI1FsW2EZzepnGeES1ghZdD3cMnW7EU85PUQnmuVDVTZVASEOBgMhEO/JxkLSMVbyy9LZ3BgGLpqKP9+zRb0zm13Z+afD2RH0re0j1o4pSd1caxW6jpPTRMeeFlh5p5iEjhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUxVAsooR+2RFdhzhFi4V4gvOmewhBSgNTPp3whGNQM=;
 b=bnHSEERqIC/PbGsoDGa1U0L4lsK96DCNCvpBrRcf03pfX98zeHJC0l1ProAYICQboV/4+/cjIhi2x2zmUgMEzK8VL2mrsfzPOOHZq0jbMDJviEkSQDEqreyZez2+KnW/ESvGMQFIhPnCi9/TpooPqi2ppzxe6jEBoeHsbJkrwKP2QbHnRMEKd3aXeh4lOrltPhcbxqpvStcIucVz0h8qS/NH7hEA87qThgScVrsG+exCApnDK88Z2lj8bFoTN7wMPvWQxnBG5Ro8ncSoVw/gbYoPyuqwmp69se6tkN/x52p9gUzPUBSQ87IzWgtxEjQTFrhYAA+zmojI5acjxBseeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:09:11 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:09:11 +0000
Date: Tue, 1 Sep 2026 13:09:05 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 09/11] drm: nova: Report GPU name in GPU info
Message-ID: <apY_7wKQCENbNRfV@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-10-apopple@nvidia.com>
 <DL37BOJC2I73.1BK0RELPBUPY2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL37BOJC2I73.1BK0RELPBUPY2@kernel.org>
X-ClientProxiedBy: SY5P282CA0096.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::11) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c09bd4-6b4b-4576-e4e9-08df07d66551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|11063799006|5023799004|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PBb4CThjWvkwYa60LXbJVLIXqxurCGVNtsvc+PUPqDMsX7wq1z55ydc/y3Q+smqVf7lXligezz3uIqwleA0K+Rp8v1CjwJsKaPQy/9S36gmxCP5B2Uxdt9iGgIILKb8yoJwzCvBxBxpIoMpy9r1rZM0UTaHUJSJ8Q4cQwlhYtojgZ1LLFGi00T7JhjaoWm0+aXVnCNrk2FUrr9NRqfuF+elRdKHSIKTNKbcAn3XT/Et14oU+lPTVmDpmYi/DjilepM/g7KOkPiywzesWMonpvysrmDznPlC3NVAfbDa8ULLNiGEknCQltVUTE/AAuukxXo2YcB3hHruw1c6tJNLVlL1ZDmpAR6aIAVHNwjCjQmaDg4zIzhnm2uYfdPRlp4jsVXioOOG3ZJrVy0RYLnDuwaEcC0z6jBi3lS+zIPzuHhs7/ceqeGnrcJ4TH+qN/YTsQEXmvm63rIJ2GIo0xv83uabTuA2jN44H2IHNeaePTWO9juTZ/Jk8xlIXuekRHTZEyiNVsSZ3N8G1GbNtX1UDskgsgr3QWKSmdFcSYiGMBSjnuuYPsFE4hvxLvgpF+RIuURaKukL3k1FfVi1ePkGDxszz0hgWZoR/wFf3ZrYK+lERYH+n3AZb0t1JtzddPfwmDQhi7GkUjkL1APMd6ntw+Y+HgxYkWDAMAvhOJBvisbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMgnhP29JC8HopKwXT1a3gKFXF88rVHIDjHBIyRu1f+AXeRQYAC2zpvKhVdi?=
 =?us-ascii?Q?Ziob5E9qqGrKVaAMC6ve8G5yYpqosx2vvyJzUMDKojjLcNNSBSyDfSc+wSKD?=
 =?us-ascii?Q?5ZZnEQgpJYpqaa0U/oU4xLmxkYomOTtgwOR3HEkvd5xAHxPVGbWzSz8Sh+nP?=
 =?us-ascii?Q?KG4EFvx/S6fG+hubBJrFp6SI0qwepIq6BYHYfJ5cmRUIHT8pTqjBcA6737hD?=
 =?us-ascii?Q?1HfYqanXhSTXL4S2BnjfloOIGaRnrlQ2xDNTFSxYaoWjnkvsXYZRU2mnwUdN?=
 =?us-ascii?Q?HYsEwUic422Ft/UeSgQaW6B6Y5BKi3rdoZW/MnHLJTWUseNrqypGkCltsH0+?=
 =?us-ascii?Q?h/0gpMDaSYPwr8KgnuyxHKVb3FLuZo6Oacu54Jczy5sudMlukoEzBJSgT7Ca?=
 =?us-ascii?Q?wFw32XolKIHepPNH8gozc9JcZjzD+gNEiz7VYZQsRgkTzzkPL8KR+jJwPCCS?=
 =?us-ascii?Q?HKsK+rUfHSEGRdgXAZqFRQLSs//8TXQEGUyxLJExtR2Ofmo5OJlaIjVWYWbR?=
 =?us-ascii?Q?Ajw2RMR2+JVfl9R44jhfAAVGjK+1fpwkt52qYf2fXBgoYzitBcn6bQc7ECxz?=
 =?us-ascii?Q?CWnS3easquZ/OY23dS1m+wchfPSh4ofGvnRYm7ac6aPTBG2EYOa7YsQcDDu2?=
 =?us-ascii?Q?E/dukup/D8yMJOzsOtlJWwvKuueid0YSRltGudsytq4OSPsAYDY6ZppOxpRq?=
 =?us-ascii?Q?mf4F2/49PSCdAeSjPLnfT193BdTtsROBrhw6vATwxPtZUP5vf9oz1K9B3c6J?=
 =?us-ascii?Q?g3Ne4ds6zW8UZnlkKzI3iAyeNvGavIk1yL9WazJTsMCJYNhuUmBTXnwFoE3Z?=
 =?us-ascii?Q?tPLrRMw4c9Zm6kfEptGMEgOuGKp/NovM8b5p1oTVl2BFDiP1cfCoNO/WsVQ+?=
 =?us-ascii?Q?WQPLyp28kDKs4PfGgLxU6B+zug8QGDOpuOlMLZ2/Y5Xuf2ikHr2UQ2wFiCOx?=
 =?us-ascii?Q?e/Ms6ogz9Gj47XrDllGJc9bRsz4tGatRFQs0PaXd7iVj47ryDkr9ep6plO2X?=
 =?us-ascii?Q?zMbqYsHoC/yD21xhAmxM1BIe9kbplIejYXN8KjhYN/rCs/g0V4b9Ha6xY7/n?=
 =?us-ascii?Q?ahSlTvv9ubrMy8xULmrXJnu66crcr5EYQzh9CduMu7XZUrcpHOfYhngDuho/?=
 =?us-ascii?Q?3wBIiN/MydepJHhP7s1i+sfKUvm/K4QYQJCf97x77l1xpyQjqxBObbezvr/B?=
 =?us-ascii?Q?pLcBwxIgfgD1RThmVvGJyo1q+3j9j5OBmVSAxJu8qBYR9NR82Kt7Gwmhexav?=
 =?us-ascii?Q?jh/zBbdrvDNnG5QVYYp1EI6dB2X1wMtKm3nyiVt5P8yNwGeN+4e6J1Hptpol?=
 =?us-ascii?Q?k9Vu/YGpMZvMjz7tdA2RHf7i0eo8X9w4boGOahJvR6+yVntHVN9PpfkyedTN?=
 =?us-ascii?Q?RWXiy4pwmbYj09oGoULpjMo8CgfVGz5x46tuwq5QxEAMrAWoRqfGA7Li9/Fq?=
 =?us-ascii?Q?zRXENVNklbxJVnVBgfGn/hIHuawkG42chvijtQr/0D6hMSZ0/RbIViq56XWk?=
 =?us-ascii?Q?IWoD6XuHCxgReJnRVRETptN4Yxj56wyFwjuKWCu8zNzqGlTT9xVIwvheN0uC?=
 =?us-ascii?Q?jJ0Ri2ZA55TO6ALQWxK+G2xuk8l4kYnwc8PQEGRfT/I1iBLNIh0rpFUw/krV?=
 =?us-ascii?Q?rqhlkjWWD6cjnSBl1IFp0bbsmAVCxIGuH8231rphwtTUz9Cc5d236LQSg+hM?=
 =?us-ascii?Q?NIvZRCT7ljwoVKNjlqsS4IRbQ83h3fbESGGpNXgAqxxuD/SAB0bPDBfOSan+?=
 =?us-ascii?Q?AHpjqZLTtg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c09bd4-6b4b-4576-e4e9-08df07d66551
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:09:11.5108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5lxqktKqrMOS4YNTYaH9SymyH66Qrf/bd74V7E7aL4sM85mW97pjSHAbmMj2BaW5ryulUje4hhZnRBYMaDrQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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

On 2026-09-01 at 00:33 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> >  impl NovaCoreApi<'_> {
> > +    /// Returns the NUL-terminated full GPU name supplied by GSP-RM.
> > +    pub fn gpu_name(&self) -> [u8; 64] {
> 
> I don't really like that we have two separate accessors for this, can't we just
> use the one we already have, which also does all the validation already?

Yeah, I don't know how I forgot we already had an accessor for that. I've been
carrying this patch on my own tree for quite a while, so guess just enough code
moved around change that I missed it.

Anyway I agree, a new acessor is totally unnecessary.

> The constructor of GpuInfo could look like this:
> 
> 	fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
> 	    let mut info = uapi::drm_nova_gpu_info {
> 	        architecture: reg_data.api.architecture(),
> 	        implementation: reg_data.api.implementation(),
> 	        ..Default::default()
> 	    };
> 	    let bytes = reg_data.api.gpu_name()?.as_bytes();
> 	    info.gpu_name[..bytes.len()].copy_from_slice(bytes);
> 	    Ok(Self(info))
> 	}
> 
> Could also be infallible if we want to go with a fallback name, given that we
> consider the firmware not providing something useful as non-fatal so far.

Yeah, I think keeping this infallible makes sense. 

> > +        *self.gpu.gsp_static_info.gpu_name_bytes()
> > +    }
> > +
> >      /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
> >      /// by nova-core.
> >      pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
> > diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
> > index 6453184af55b..b8dc64808620 100644
> > --- a/drivers/gpu/nova-core/gsp/commands.rs
> > +++ b/drivers/gpu/nova-core/gsp/commands.rs
> > @@ -251,6 +251,11 @@ pub(crate) enum GpuNameError {
> >  }
> >  
> >  impl GetGspStaticInfoReply {
> > +    /// Returns the full GPU name as a NUL-terminated byte string.
> > +    pub(crate) fn gpu_name_bytes(&self) -> &[u8; 64] {
> > +        &self.gpu_name
> > +    }
> 
> AFAICS there's nothing ensuring that this is actually NULL terminated? The
> existing gpu_name() method already does this.

Yep, relied on FW which is sub-optimal. The existing accessors obviously fix
that.

 - Alistair
