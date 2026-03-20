Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C033A109317A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A8810E95E;
	Fri, 20 Mar 2026 04:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oZgyJeHl";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1686C10E95A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 04:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwOHm3oZaMnKtUVzVB3mCYW1I/QSCn9/qShXqZz40HIqNkxVSh+s5QWigvcDHxvxEfG5c+113Pkqz2uqt7I58JmYKFgc3nucGiVqgLtvZuLbMT+vRmGfK9P+MGxVej/F9EYh6bR0dHWspkmuuw/7MxGJER84ejAhVVGgP5Tvv/lKEUrWNbpbPj6BEy5tbfpY2D42XvGFg7rFw3FwOyQeQ1Y2DpSQPtd+XjeNzDbSUywcuVn676BWCTF8w02mpILOS7SN4N/PAcSGkX41uxbg+Vnvftq71ZIiOJWGr1fXV+UScsK4jH09u1R1F6YdIfXGcetO5TrCX0VpKdPqxxqmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTbEojRmVUSU7kZ5gsqD1ewCbycgnMzvKJnhTX7tCbg=;
 b=WxbRLAZuPhg1ZIjZfOUuwTDJ/OaUSMFkuYgz0ysdWj/QQGe+03Gg6FOjBX2hCsTcG3SyO0WhHwdUSwX0tBD/P1BJIOPQ1pGSbmGwMZCuQQQVKrJK8XQgb8Cx6gZUI76HQ/k6g3WUm6C+Us/eqq7uhDQTlD9sMzw6nJ+una6gmPpKQnk0+B7xmA6iqj3G9tpgnMwr0q4Qol5mqXUFNFohagYyk/vYtuHAyguSAo2hSc7729rnKgE1JS8Cs5dqvlKTDBZxZIQZ1nInDoQgEh76ezyj/2ciFHgf4RJIgjss6WmD/wej8ujdmAuP0zgAZES36pVcdF1pNg0ACLxTGwYt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTbEojRmVUSU7kZ5gsqD1ewCbycgnMzvKJnhTX7tCbg=;
 b=oZgyJeHlTtC81znxrtYV0MSvircWQsv8bguYR26t6ddY2ff/4GSgstJ+Rhu6151UlFVMnX+kVwBWO/1EcubKECuDopsD8KCtLN/jWn63Cz5QTqSbAbF+At/LWA7v5alR2/Kc6xJw75C162GeMWT1qGhAuMk4wX4g1nJ4JalxqAAiR8MkX5aNeb10vPeTFWn4gBGIWReqnJ6b91LLxG0tqZUpSv0kWYOQ6eJJrW/s1O9J5O3iuytQmNZELLGy12Zfnr92yt6+U4+rqjMo/bF+QbitAdg6+l2JowK/9gYU3T/wlzFD8zj/Qdrodu5lPZ8k95TZIJcc+YsD+WSokEN5Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 04:32:35 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 04:32:34 +0000
Date: Fri, 20 Mar 2026 15:32:30 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] gpu: nova-core: use KVVec for SBufferIter flush
Message-ID: <abzMyv_WHE4CUyFf@nvdebian.thelocal>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-6-9a9fa6f1c4c3@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-rmcontrol-v2-6-9a9fa6f1c4c3@nvidia.com>
X-ClientProxiedBy: SY5P282CA0147.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: d36e5972-2b8f-4167-c875-08de8639b559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: pco9tKhTnMqfyxrXAIJUugTytaMTEPkF/CLtpZ3s8/G1H378qe818ha1LQwDKGmsDBwRUeeI5RdfJ85aDw5re/akQe+iENLADPS5C6RSas2z/mZ/MKAJzTJaMpw3BymRxPvM+X2NmCTOJNuRja/WJrqAlxZxGA2l8bJxQUQuf9qE4+/+qkd3RQUNo6m2eHJB3j3WWa4lz+hj+DtG8dlwoyZCINjW1iqcxLN4XxgU0/S61uXHQAfgXvGVyCNrm+bF/M3ygSO07Cbi/u/c4cXoG31EWMpHvxoOVY7nvQIzuDcsaNwCbYN31sHxCZzjuB/9mYWaN5i17Q8tXi8l4+WffUAb0m2nUI/WbmWX9WDw9phCr91YapBq0PDK+yNgQiwQqwPVHtU8WwTkxHLi1CczXa54Y1TCmRMCLJo6SopAg0UQTMmdCVxnug+CVLNSgf458niC3EAK6CM/ZrnUgaLff10n9K+u5RKRRDyix3FfOQkUKtgySAqvCLb4IM6FjF42n7XM6/FGZ1QPtQBt6tVAf9jqdH/UXnvZY13Y4gk5y46b9QeXF58piEjkCjbr/CR0EqzKPbocEKVYw1vm4ZZubauD4hM/qkpKqTxQ6aJwx4gxy2iWHwjR5LVq3pnIDM+OIXqEGtPTZPWj+DaMcFpEwnPIy3AFc5kONj92CodGjfVzRlUONdDuWSpYuummp85fECkZl4lRyl6F5w8HYBimLC3M99wiDPzbQe7WrlVOnlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RytK+lQ8xUu6oQvDYSwvF1Otih0U/KaDURugV9EZuNdWh0SQhMW0moVv/zLc?=
 =?us-ascii?Q?qTA1LLGDjVxJF3wgyuGM4IKezEKNd0kK7c7eOA2YXqwaOZG1rDCvHRh6hZNr?=
 =?us-ascii?Q?PLsMhx8UbTZncTxHNuN7jOfZPIZDC7Bnvqi6zA6kdt6ocO/x2Y3rtTHjoL7U?=
 =?us-ascii?Q?mC5N9xj2looWSKjN6ZO/YnY89kGLl/1VxacCcXF/HAbBe2qg4neBv7wRAtAq?=
 =?us-ascii?Q?KLo9MIk8E4qXYwk8nQMhSHI7B7S/PR61eCRwwbkeCbKQ/gRyCVl0/5xaoGgR?=
 =?us-ascii?Q?HTOw8EE2UL9fHR1ZY7pgMtvBRlrN065xoIAzltrag5URZijXv2sdlp1B2sFs?=
 =?us-ascii?Q?YSug5gI5bU7XaZaN2Na/EsVM5lourCStISVlS7iNKvvi+AKJo7InjgN8v4KP?=
 =?us-ascii?Q?IG1wIXz3yNNAdYoPYph4A1tOtw9D2ECMm0zoQPPROQ8eG/YY1DIAWlgq7QsI?=
 =?us-ascii?Q?wg6MBHpc7ZJtrvNJUJTv3Q2Oyn5u5+5RrMf6G6ht/MwqMI1URIrmL0L6+rkE?=
 =?us-ascii?Q?GvGYG6Aj84g6z7cNMntxBl0M9fqjVHWgRgXlwGziEgx2WOFcMXS/iB+uvle0?=
 =?us-ascii?Q?e0B3lS+HDOy22qa21ENvc8oBbelfGDwRRhGTTUVCHM+ge+lNvu88TQyuGmxz?=
 =?us-ascii?Q?tiKg+tsIvouA7C6eC197QShsypS3Z3/hmSlPl9tE6r6sssG0MVSDOLagOIZa?=
 =?us-ascii?Q?DB63scVh0awfEkRHWkyJQFOLBL+IWYYoTmYlWMwrklpEs8/1LfbYRNg0cKBo?=
 =?us-ascii?Q?dfzggGvaDEgW4fi/3WY0PSxIhifwcjb7m4aa6k7otZDKEhi8cHdQjInSAzUj?=
 =?us-ascii?Q?sgck6jm0VwjdwA79LAaw6C18/fI14ca/PptFANT8Y6obO7seHk0pqKQnLlkX?=
 =?us-ascii?Q?XqngR3ZqWorMZ/bweo5lJ/dQY/g+zo5iVz0I1vtFnhSpoddg2PF83nmdT8+H?=
 =?us-ascii?Q?CR6g1pJp6fEDDv+t3VrN8tx1hUpz2aTKFI8ckEfdloh+PoJbZvUHxNNTa86u?=
 =?us-ascii?Q?lsNk93wxR1a0gHR/0kBPEJ++mPQAiEJ4r6oaFoJ0mggN90wVfhNH+rCnqxyx?=
 =?us-ascii?Q?dIKi/JMe4j94Vm9wjc/jJPBM4WMm+Xrz2Vmapz7uXRdfYuo3rMnYHFnBtIHS?=
 =?us-ascii?Q?WgLwNDUUwsj/R+Xhk8pwzmJPbGOhLf3HDNpcNTRHt/8bqXfWA2K828Y//k9g?=
 =?us-ascii?Q?GroYxnNEMcKtFhv/90Q1FaFHDxaWnCUlAvip3hF/Jzt+GSU0atBalI9v7D0R?=
 =?us-ascii?Q?lA0tYeJQTUZFuli0zUhPg2/hMfIf7/MkvV4ftoHd4sRbQAhriP0AdFekqCZp?=
 =?us-ascii?Q?L9F12VZjH16lq5DjKc0ZKGekpZ8Ww5tHViKmQfaP8N2+or/yjq09sSRrZEPG?=
 =?us-ascii?Q?kc34f5E82DbSaY0vow8e6aJC+cIBJ07dBc1fpVsUt4jyayy0bxLcvxZ0bP9w?=
 =?us-ascii?Q?J3VfY1NKFn+iZ9SnKfSF/ltz99kkXrO4WCUaFIf0qs0fTCloCOlOfbE/BX6K?=
 =?us-ascii?Q?8UxTUO2CJSFWkIUCS8p8KQysOD3PhoK85fcjAeW0wq/5Yz6yE0LWgFZ6T4I0?=
 =?us-ascii?Q?f1G5r3wfhVg4w0nSTcY9McCSt8cNPVnT1xDOUXcdOtyoZQsQwqFkakJ+Yi/L?=
 =?us-ascii?Q?E28vCPzyluLv/SN9HvCkURdyFeKP0AF4qWty/rwyHpcHuDpbC4jLoydk9Wpp?=
 =?us-ascii?Q?VgjzBMcwGlq3pAarBzx9YOExSRFc6olAKzxVJaRjz7iYb0O8dDcsBs93pRQ4?=
 =?us-ascii?Q?hHBlsjbp7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36e5972-2b8f-4167-c875-08de8639b559
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 04:32:34.8839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vWC949qFEgrhCpcuUEMy3WhwnI13VsuIyILDCcOqdy4borbNL1oekreczRronxxeg8LWzmrcvpNL/frIZu3pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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

On 2026-03-18 at 18:14 +1100, Eliot Courtney <ecourtney@nvidia.com> wrote...
> Change flush_into_kvec to return KVVec instead of KVec. KVVec uses
> vmalloc for large allocations, which is appropriate since RPC reply
> payloads can be large (>=20 KiB).

Out of curiosity do you know if there is any upper limit on payload size?

And is there any concern about performance of vmalloc() vs. kmalloc() for RPC
messages?

> Update GspSequence to use KVVec accordingly.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/sequencer.rs | 4 ++--
>  drivers/gpu/nova-core/sbuffer.rs       | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
> index 474e4c8021db..c8f587d2d57b 100644
> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs
> @@ -42,7 +42,7 @@ struct GspSequence {
>      /// Current command index for error reporting.
>      cmd_index: u32,
>      /// Command data buffer containing the sequence of commands.
> -    cmd_data: KVec<u8>,
> +    cmd_data: KVVec<u8>,
>  }
>  
>  impl MessageFromGsp for GspSequence {
> @@ -54,7 +54,7 @@ fn read(
>          msg: &Self::Message,
>          sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
>      ) -> Result<Self, Self::InitError> {
> -        let cmd_data = sbuffer.flush_into_kvec(GFP_KERNEL)?;
> +        let cmd_data = sbuffer.read_to_vec(GFP_KERNEL)?;
>          Ok(GspSequence {
>              cmd_index: msg.cmd_index(),
>              cmd_data,
> diff --git a/drivers/gpu/nova-core/sbuffer.rs b/drivers/gpu/nova-core/sbuffer.rs
> index 3a41d224c77a..ae2facdcbdd4 100644
> --- a/drivers/gpu/nova-core/sbuffer.rs
> +++ b/drivers/gpu/nova-core/sbuffer.rs
> @@ -162,11 +162,11 @@ pub(crate) fn read_exact(&mut self, mut dst: &mut [u8]) -> Result {
>          Ok(())
>      }
>  
> -    /// Read all the remaining data into a [`KVec`].
> +    /// Read all the remaining data into a [`KVVec`].
>      ///
>      /// `self` will be empty after this operation.
> -    pub(crate) fn flush_into_kvec(&mut self, flags: kernel::alloc::Flags) -> Result<KVec<u8>> {
> -        let mut buf = KVec::<u8>::new();
> +    pub(crate) fn read_to_vec(&mut self, flags: kernel::alloc::Flags) -> Result<KVVec<u8>> {
> +        let mut buf = KVVec::<u8>::new();
>  
>          if let Some(slice) = core::mem::take(&mut self.cur_slice) {
>              buf.extend_from_slice(slice, flags)?;
> 
> -- 
> 2.53.0
> 
