Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B21BCD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926B410E25D;
	Sat,  2 May 2026 15:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="araqHMjb";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CA310E25D
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s97Eh2j+9NEksu1ECUMcfQ/hDMkoqW2j//3XoGHKV7CYDrlrrwYQmpT3+n/Pp2bkD1v2uiBlnrYwVlawSuR56wvX+28uUbD9zPpGbccpgWE7lwOvEhn65+WqZN3US3vmlMKYGVtmuFWb7yI6Gv3Uw9aOlUGQUvunLxJeUejFGgwzMQLIiBZ98JqAVMEqBrmTZ4Gulkbe0OC/milNcaYzXjIklPKu10f9n0dj36C8q3/d8DUmXEPl01yMHXHir6uIDGRbqprLJFsPRiBppe+SLFfcm/NERFuSOtxksEHXYFTg1vVc68BydVjRz/eUIr0y0Z2uN7vYoZ/TcLhmGvO9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr6ljaYxcBmvnXgUdT/gD5E+h1DpAa7dkm/qD8P/y4g=;
 b=upDv4k30AQt0gT9QyKBxm+3LJixVOWQlcy1BHXKPGOG8PAIWR8Jdg40W2SXD3s+Ozuo9V3xyUc+L2/Ogvzb3pWmtmdWQYHrrv9TqhidtL2Qg1N80gXSRMsGWSq6H9LWnVlFdxFe9+6ZFZMeJInkcHkI0zOCSrnr/PpOz2YXlj/rng2VScg4qblTOKQvGWJawbqgMWTLdWkZ56I9n8+s7U512rgTdqMfmIRvpwVDoVw6Wgj0GCkFXNoiYhKc/P42tcHSHLBY62M00zA9t+/3dv96tZmvEhpcODQVmnXp1w1YvX/bzm6Ekl5yHFTb0hSETrWNAQ/o6V2jYI3Z2phG4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr6ljaYxcBmvnXgUdT/gD5E+h1DpAa7dkm/qD8P/y4g=;
 b=araqHMjbDakdcgpE8UiodKf49G/kI4Oqx45qgQXMS4lBnlkwpE/OoiL2bJNCpi1nKj3B2WHxVuhZxKtTunhy+OE3xEzEfpyqmi7I/pf5WT9zBntA3VZK6icidw1HJcswpZA6ILRA4XcAhuI3+FIwlAsB+EyXWJ0/l8HYGwjAtboWLyEFnQNxqu7LAboB+g2OxOUsClpkjzBXkyQoF1PVqMPvnLNPbO64fYP+mcpCuRqpKL3QHQwExxofulSpyodMP1n1BaZZ4LEpt/tqSQUo1GRPUO2GcH6VBCLgSXewSeTBFoa88UzZuIL5OCk5WANYiRQizYnqGy67SHesFZhr5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:41:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:41:44 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:41:40 +0900
Message-Id: <DI8AZTYWPYK0.2U0NV7Y5V9CCB@nvidia.com>
Subject: Re: [PATCH v12 03/22] gpu: nova-core: gsp: Expose total physical
 VRAM end from FB region info
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-4-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-4-joelagnelf@nvidia.com>
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d791a0-3051-4ad4-0675-08dea8615006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fBr/OhhnS58ZnsiQA5BExK+8MkEHVTYfpjBt1kVdMIxlfUPMnaOTeL/k3XV5p5SoWkPZ5WXcNqSTjZ+S5SFf+/K05sSpz0M7C/Nyd4iGwq5hXPCM2egCm5XtUVubRk3kDKg1833p4/yuv2XcXiSJ4TOx0suLKuDpaWv/ifFOb8RQiit4NnlGe49RwOGwycqAuDatsG2xceLwvGaRS9I9DJFXiaQ7zqx/b1aK1YCHqUzXCYaryb4c/ifDKsBGFceKjbaMdmRcui2AvCJYl7HBEOTUspWfOXZ/07Uc8W3Q+fnz9EMuSBk5JPXIvezqllxSximBB614+npdMlPtKpPmCkiLHrtH6kSyFOWLSEgyXP8lF8N0r22fg9GMXraHpgv+G8t4JFsLkox0BXRsCOdKG0UlYqKMsJIliDhvErUonCl64NyjgAeA7zeMySOU3uyV26QViaoBdJ8xF/cKL9PBfPenJSNX9xMHJjHqhozBTHou1+HbxdX0KATVJfbebY1EFYMU/BGZOd+Qmdoo6NzUEChjkYiWhQj5YD6j4xfGp95gCeVG8GbFcQAGqGEk1d3PUwoawcNGFlVTVolZB4NjnNevqCizu1DkVX4eFo6kBzniZcelgKDTXzCrLESIQC7hKO8KW1p07qMNifc47nEzRpClloE0LENa/JKGzZ/dbZJn75zJllJ5gOtTk/vsONEB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RklwUjQxR3hsb2E2U2VEdHVBV29XVzNwelRSTEtQQkxLczRsWkNBVG12blhl?=
 =?utf-8?B?ZjZha2lIV0RwVTJrZElkb0ZhQUFkVm5oN1RGUjNKRUk2TXZPSk5xQVJ2bHk1?=
 =?utf-8?B?TVhiZS9aVDE4RU5SaFU5VjQ4OUVpQkhjYklMSStUeEdsbnZFZW1sdlJPUEN2?=
 =?utf-8?B?bklJSVMwWWUvR01Kams0NTFxN25OSHc1dmJqTHVhamNpcW5za1czWkZ3M3BN?=
 =?utf-8?B?SExiN0VORGhYR2JkZ20vWFY4ZzFVUDFacFplNVVWR05XY0pkalhqaTN4Slpn?=
 =?utf-8?B?SG5HMXBrZENPOXBKM2ZkL2JCK1hubHVydWd5V09NL0VEY20yRHpzSk1YaGd2?=
 =?utf-8?B?SW1WTERtWXVRQlJjUFdER0tsd0V1YURmRWprWGwrMXViQURkeVBabENCVmRO?=
 =?utf-8?B?ZWl4WkNIQXdtY3NacE0vNDhHbGxJYVQ0V0NmNkNEMWFiZ2krRGx5RWgvckY3?=
 =?utf-8?B?K1pBV3I4dlJnRWlDMk1IbEJvcm9JQ3ZudzM3UmdHaGwvWUlubkpRelpFRzB2?=
 =?utf-8?B?MUtEWmVUMnF6aURkUndjSGh4YkR3RkRhMFUrMDk0V2FEYkpMTG5lV3NlOEdO?=
 =?utf-8?B?ZWo1Z2taZUZDNXZSc0RrSEtUYU9raS9JSFdqS2JCeXM0Y3BnZVlqbGMzQkZx?=
 =?utf-8?B?bC9ENWtWNWJ3UHJmTEo1ZXZyd3JMei95NFRtR0wxRllSOWk1LzNKTWpncHc3?=
 =?utf-8?B?elhIUWl6VVVHeElIY1kwMzFnZnJnRXhJdkYrSXRRTFVIY3YyWXMrY3g5S2E5?=
 =?utf-8?B?TkhCWEtaTWdDYnBvWXFWcUF3blI3cG1Pcm0rcTJvbEdzRG1NdElkZnZSTjFo?=
 =?utf-8?B?cUN6b2VNVEJZb0h5L1lPY0g4aUh6dk92UE5XOFR4dVhOeDNXTGZueEtnRmNZ?=
 =?utf-8?B?WEVIamNSTGYwR1pBQW1vaXZ5Z082NTFSdTZmTjZWK2g4SndIbFBzd1dJSXA0?=
 =?utf-8?B?ekZiYW83bEtGd0ZjelBCeW8yeXdDTnhhWnJyaWhoMTE0M3RwRWE2OHc0d3Aw?=
 =?utf-8?B?RnNuVFdXWUpzcEtrRGg0VFRaQmtvRmJMU2hnTGIrZWVEOUt5U3QvK1dPV3FH?=
 =?utf-8?B?eHZpQVY0SmxMcmhQdzlRMTJkM3lRUzdmSWJLekZlUHgyU2pRRVJ3c1RnUWhZ?=
 =?utf-8?B?MkpkZTdRNmFFWVpWTXdtaGNZTjBnZEpxeHh1UlFvSTFsK0VQWEEyMWx5TUVJ?=
 =?utf-8?B?bm9oV0hLVytiSDR5U3hTWUNCSXY1M2ZwZ2h3RSs1czFKYXVoTm5OL05iS2xt?=
 =?utf-8?B?cFpIcWRmNjZqa2Z3ZTJCRHVybkFGRmE2Zm54elhIdDRPYVJnTTlOL2FVcmxC?=
 =?utf-8?B?WG5SMGNyVlI3KzltUDZ3KytNV3J5S1ZVdEpDb2REMENCVjFHR0NIWXZIdWp3?=
 =?utf-8?B?WXl5aHF0YjRoOXpKMFdIUDhPRXllQWFBWU1lMUExazNCV0cyaEtaVnhsVFJY?=
 =?utf-8?B?ak40U1p3Z3phMmFJVTZNci9PNit2aEZ4NkpmYXhhOUhuenlzU3BhYnhqQmE3?=
 =?utf-8?B?Q2lSOHJRa25kMElFUGE4UEdsQmVNNm5CeFFHNWZtM25OSkljdy9RODFrVksy?=
 =?utf-8?B?SW1VMUJlZUNrWU5uTTYrRlVqYm5rYUdiS0JTSDU0dzhsZFZTSXpHYmRtbnR5?=
 =?utf-8?B?NzFldldFTjZ6RVg1Z1crWDY0RVYxS214Q2gwdGRETXZGOENPWDFmcjJjVWtW?=
 =?utf-8?B?OEpjWDh6VW9ORHhTRTllSkUrZ0VBM09JZDhSWVEzRlNaWlFzejEyVWl4R2lq?=
 =?utf-8?B?dmZtS2dKOGxFOFozQ0tTU1c5SnE1K0tUNGVTRjBNZ2lINjhrRnJxVVY3azZB?=
 =?utf-8?B?QlltbGVnNWdibTlrK3BmNjdSYWdKRUxBWXozMWxiQ2dJdDhFQnVVbnRxUXp1?=
 =?utf-8?B?Y0hPeTNmMHVkVm9DelYyd2Q0eEVJUThJbEx1c0huSkkxV0Y2djZTbkNpQVhE?=
 =?utf-8?B?MXdzQkcyNEZvc2N4UFJJRHRNZFdLaWJmQXNBbkIxNUdBR1FhRWZlMVNrZXlo?=
 =?utf-8?B?YTJ2cWd1M0YrbllHS3NQa1MyWG45NjVObXgveVRqMk5WWDlGV05DYy9vTW5F?=
 =?utf-8?B?ZGZiOFBkb0ZldkpVaVJUbm44MDNzeHUrd1FOL1ZLWk1YdTdETjZxNmFZQkkz?=
 =?utf-8?B?MUd6NFBMT3RFelNVS0pwd0ZnanF6ZURyeGl0UC96ckpXdkFNTDZhZG0vMERJ?=
 =?utf-8?B?MFJ5VkdTSFJ4UExlcnhNYTZZT0l4S0JNc1Z5c1VnWjBPWDM0cDNEZnFPZGNV?=
 =?utf-8?B?NHdydG05cG1uWjJqTzBITldXWUt0WWNHMkREV005LzBSd3dSOXpES015YzJq?=
 =?utf-8?B?VXorK3hDVjlyVXZMdklqVXZGOXNpUE5lT2l2VU9kTUV2c0JyMWtQSkxZQ3Bo?=
 =?utf-8?Q?hKcToEl//ALSfhEafhwqCD5mRjLwhA7gpo7XJre/cw29b?=
X-MS-Exchange-AntiSpam-MessageData-1: akJBp8UtLC1xDg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d791a0-3051-4ad4-0675-08dea8615006
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:41:44.3949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhhXMQfuYzO/c3ml29NA22Uy7d3n6azP9mRo0qNamDI8bpiAL80T6f0nyZNJdBV41CyvZy+yQD3IBTd3JSTA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
> Add `total_fb_end()` to `GspStaticConfigInfo` that computes the
> exclusive end address of the highest valid FB region covering both
> usable and GSP-reserved areas.
>
> This allows callers to know the full physical VRAM extent, not just
> the allocatable portion.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs             | 12 +++++++++++-
>  drivers/gpu/nova-core/gsp/commands.rs    |  5 +++++
>  drivers/gpu/nova-core/gsp/fw/commands.rs |  7 +++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index f2a8915a1ff4..675a0676f032 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -273,7 +273,17 @@ pub(crate) fn new<'a>(
> =20
>              gsp <- Gsp::new(pdev),
> =20
> -            gsp_static_info: { gsp.boot(pdev, bar, spec.chipset, gsp_fal=
con, sec2_falcon)? },
> +            gsp_static_info: {
> +                let info =3D gsp.boot(pdev, bar, spec.chipset, gsp_falco=
n, sec2_falcon)?;
> +
> +                dev_info!(
> +                    pdev.as_ref(),
> +                    "Total physical VRAM: {} MiB\n",
> +                    info.total_fb_end >> 20

`info.total_fb_end / u64::SZ_1M` (after importing `kernel::sizes::SizeConst=
ants`) would carry the intent better.

> +                );
> +
> +                info
> +            },

Let's use `inspect`:

    gsp_static_info: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_fal=
con)
        .inspect(|info|
            dev_info!(
                pdev.as_ref(),
                "Total physical VRAM: {} MiB\n",
                info.total_fb_end / u64::SZ_1M
            )
    )?,

If we combine these 3 first patches with the series enabling calls from
nova-drm to nova-core, we should be able to implement a `TOTAL_VRAM`
argument to `GET_PARAM` that would be the first example of an actual
Nova ioctl using real information from the GSP (granted, with an
unstable interface). Looking forward to this.
