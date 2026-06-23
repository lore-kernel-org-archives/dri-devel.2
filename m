Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2B1CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE6E10E962;
	Tue, 23 Jun 2026 06:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qH8+bYdB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F05410E962
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTDqSzxjbFu0qNWiOOs+qLaYjGyW6jeMQ3vcRTEJwUd7UpkhkkF5tUl1HUmJ8Kt9wlgm+ZPzzPQmZGu9Ic66xy41UpjeQtIxIeA/SPruAC+6IF79QVWqC43RuoAT0JCGzJTpEmsooRYBKdfytTuZ92b/0fR/JrcCXkAFMt1xP2DheXVsXHuLGmcI3ut/mE3GRiWibGSwmBCnHO5XcQxZdUdt4Xj/vU9ZSGuXei7DKPXAw0H9KJHDU3IUVQ4p/pnBD4TqVq8QusjterOInOWLDu2WaPTdQ+LjcQIma2snBgqDnjROddMHv7iIM8qdrsp+EXBYwqwGGdtUVYKPjCNmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SncAmowpf49uXr2NoNL6Z8oA2FZP4qqNkm09uCpdJlc=;
 b=GsrYCJ7/nnqiuu1o+QHwAaPyQfVo64rMijI522kqZAjL/eY6jHS2cjslfUBXvsrr+NbEIiUQLWBUnUQWYYrNtQZVfQnT/o8354QkM0Kx+SNgrajg5XUQSvOPd19nKI8kOUgC1LJLLHWmHjS0nouedJfmvG8EMsTgNW46XVbODvn2Ot6AZxv1ooITV5b4ETXWt9ViRIcDwziLv8GS3GnKp5YGG/Jmvqxbcu7cfNrlHxHbx1dACpT6kqUzNnLHzscW8TA04j/w7ujFz6t54ixFtb2zOd9KonplrH7Ajw+M6wUGfwShcIeU/+So8oGyVMmFSvvOBYSqy1HXvaRd8mx2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SncAmowpf49uXr2NoNL6Z8oA2FZP4qqNkm09uCpdJlc=;
 b=qH8+bYdBe/zgPle4gtlSyRCyLopyE329zNyqPkVMTc7pyXEv7A3qwUCdHbUz+B8tX91KOQ9xP3WYO9myordx1C343lh/JHvTFKfQF/V+S7tlnljJBPuh49sG/F8F1YHWzJt8L9YGx0WQrXJgGTYfPCx/URkSvlnK4HVVHGn+4X9YnoRJFI0MFPNxnN24fJkpbqo4TBN0pi0mO+CbyQ0kwnNT32zI3Y07lzjhTRa/9hquftwm/KiWwM37x1W9RkCzIHXGDN0TiRmRvEnNVROt1UxT2+MmqjqbFuSPtVKiooQE/KEkwmVQtJLyJOO1CyFE2ExXDAtKkmbMDlDFcetQ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Tue, 23 Jun
 2026 06:18:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 06:18:16 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 15:18:12 +0900
Message-Id: <DJG7KQCAQGER.2R314QTLSNO9R@nvidia.com>
Cc: <dev@nanonej.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH 1/5] gpu: nova-core: fb: Move PDISP register definition
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260617-nova-core-regs-split-v1-0-4c7dc4450ea7@nanonej.com>
 <20260617-nova-core-regs-split-v1-1-4c7dc4450ea7@nanonej.com>
In-Reply-To: <20260617-nova-core-regs-split-v1-1-4c7dc4450ea7@nanonej.com>
X-ClientProxiedBy: OS7PR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:604:25c::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: b615fbc1-cd81-449b-7cd2-08ded0ef3625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|10070799003|23010399003|1800799024|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Fw/VwiF2yhe7lpz+Q9zjn7jTbuCv5hqa4eaic3T+wqVan49x+xzJwRDN84yQZRy5HER3EqCwjWK5HsAfHahusr+CERLeTeVsm/JjjGZxvkKQEMBM0FAM+kVq3EFJ/ztx37tZKNX+DkvztF2ojaxPPl9oXI/ixO/eR/wYzwdUkMvjSm7f2edLLwWOKOdzPatxNZV8mE/PRCM9IPPY0q6zQJxkRXxYsYOB+ucym3yzcu7savrzgST+9C0Oiz9z+oeVuUW/iTXhFNYazun2a1exL9Pa00cggINoclFNaa4ANaWJtvJQ9MOFF772HpEBG/COGmP1Nitj+/7vcfm51+1MBlxY1VzNMpVTkng+Yg85EP3jYAynPSJ2JlJJnNg2CxQf+IdWBl39sSm70BX5uvl6YEn1mEsXl1x/d/iVNymGUB0Qj0YQg0ZHH/dfTY/Z7PkOyFpoPLLAtRBOZ0dnNkPNBgZ+JRP6Ngpl9hbwLCiuGrp4kHqJaOZpyQysrTfXM8ZEOwcgv/FIBeEG/r4kyuqgCYQCcj+jo0xrsgQaGkNDygfQJAuK4vNngaGBB1L+Rn3t7t6tUvXPC6DhqMSfg3eqwTHPtRXYgsgbtqvL2Z5AmENOuXrWr94O76OpBD9Y87WlvPnA2seg1p1VtU9floMibp3qAM9gZrD0vLq6dW9Xeiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckMwUTcvai9aR1FQblY4ZFdrQjV5SzVsamU5dUtrZ0RidkQzVGM1SFRRSndw?=
 =?utf-8?B?NThIZE1wNWIyQXptZ1JQQUozYmhadzFONXpLWDZabzFBM3pUTysvMWYySDFO?=
 =?utf-8?B?eW1FTm1rR1U3NllYL21FUEI0N0dNeityYlhDTVB3WHJFRXFobXc5RlE4RVNl?=
 =?utf-8?B?UGdwNVlZOWFNb2UyeXFpdjNLZE84L08ybFQ0dnBQbGJFdVpxMFV0eTFGdE5U?=
 =?utf-8?B?OVREMkxlbkNPa0FiYWZZTCs2NDZ3dFVxNXdMM2NZd3JHTEJCcmVzZ1RNNUdn?=
 =?utf-8?B?a3J2NlU4RWpiVTlVQmJnTnZwN0pIYlRiSkl4R2x1ekw0UDJpb2JxbkZOMVNZ?=
 =?utf-8?B?eVJVdzlsVEJBdXM5bG9nRFRObXlHQXVPYk1NL3FFZ1NvR1FmMVU4MnNsbUNz?=
 =?utf-8?B?WkhmN3pkZFpucE1UamZUazQyeEI5VkN5SXBoZURncHN5Njl1K0FxbXhJd01B?=
 =?utf-8?B?ZXZaalFLa1NhUisvaTNPSmVic0s2SDNZc2xNVHRMT1R0Ymg4WkNxTDNTQ0tp?=
 =?utf-8?B?ZDJZSUlRSHlRMlNPT0VpVW5UbW0vV3NFZ2NldVpsczNIcE5jMVBaOXhGb0FU?=
 =?utf-8?B?dTBRK0ExZEJiU1lvVzhxcGF0NnMxM21CcjVMRFFiZnkvMzNkTWorZkNmN1ZI?=
 =?utf-8?B?NjBBQzFqVTVBeWU1Qm9QVG93RHdmRksvcFo5SEZNbUx2U0hiRzA3bkovRWhm?=
 =?utf-8?B?RTB1LzFHTkRTU3lNQjVBR2I3WTlkOW1YZGdDbWRMWTRwdklqbmxSaytQUzE3?=
 =?utf-8?B?akFvU2xnbzVQeHN0ODBqd3NwaTY5T0FwbFg3Ly9sZkR4QzFPcStISTB2YUhF?=
 =?utf-8?B?eDN2NXduYit6WU1Nd2g0OWdVdFByWk1FczEwV0dDQ1VMMFY4UHp3RmRNYXBS?=
 =?utf-8?B?T3ZwVzJYNHhSbDZjWVp0Tk1wem4wdkRCRVdxZUl5N1cweGgrZWQveGhVQ1JS?=
 =?utf-8?B?QWVHWUZjWmFrTUNHdXlZQmIrSUN5MUpUaC9EMThzRERRS2hwTGxKcWJ1WHpE?=
 =?utf-8?B?ZjNIMi9xUUpsaTVVQldJMHA1bmszbU9RVSszclBjVHVhYzJWZU1mSDFsZWRS?=
 =?utf-8?B?UktEb0tQMjBTeEVxQ3BLMXU0VEtBSjhpbmJGTUNPN0ZRWnR1QVRYZ3pRaUtt?=
 =?utf-8?B?Y1lEc0RVM0ZMQjcydE5QTCs5RDJoZ0JNM3lyeHFNeDhhL2d6SmpROUd2b2Y0?=
 =?utf-8?B?dlRvUTBzOFArUTdtRnZjTVFTeVJjWXRuZ1Z6VmIyQUlxcE5jVms1QVcveEJ4?=
 =?utf-8?B?T2xUMC9iWHpwMG0xV1pubTYyTlNQS2UvcnVFT2ZZcXpLV0x1Ny9PTEMzZzZi?=
 =?utf-8?B?bUljakY0K2FZZ3I3Z3FncWY4K3ZvRFBsYXY3N1VYRDE4aDUvKzZ2R1JpUVRn?=
 =?utf-8?B?U290bWcxbDZ6eng1MHNFWjdYK094eU9JQ2VKUnpRZXprTE9vOCtpT3BROEVK?=
 =?utf-8?B?cmlWdUw1S0VSMmdaTjAvR1U5RW50TVhFRWRCTUJmdms4TWN3SW9OdVRmNGl2?=
 =?utf-8?B?NkVrdmpxSldaYUZjeHp2VlJML2dDMHNrM3d2K0ZFMW50d2dBNVVEYWFMK0Rk?=
 =?utf-8?B?YzBwVStMakxVOXlJWHN2eitXT0NaODF0ZS9tUnAxWEZtcGRrcXJoc2t1eEVW?=
 =?utf-8?B?dklKYWlOWU1PNXpwZ1pyYkhqbVZUeTR4NE53c2hDODZkS290Z1crOVhXWEpD?=
 =?utf-8?B?SVFpV0hIV2FsSzJHK2FwRjh1Ullab3MyS1BaeE43M2MvWWJvbFhHNDNyNjlj?=
 =?utf-8?B?MHlzcHdiQVRMcEZSMHErc201TVcwYytIZDBCK0RqWlN0OTRDUkQxSHVhaFlD?=
 =?utf-8?B?YmpCR09Na09hWXJDQjN3OUliaDY3cDh1aWtWR0ZPYnF6UUNBUGUxVTgyb0RS?=
 =?utf-8?B?Nmd4MDJzSmsweDJXRmc3ZHpodVVuQkJnblAzaURidW15QTFUdjkxYjV0VGpk?=
 =?utf-8?B?c2xYZXpuT1QvTGtoSjVJZnJpRmoyTVFIai9PWTVWdktGMGV6TXF6eGE3MVMy?=
 =?utf-8?B?QUhEUHBKM2ZCWmswcEtFT0xQSlY0ODg0aDlkdXZTWEt3d3JydStyazI2K2VS?=
 =?utf-8?B?d0pKODIrK0JrbWVCVnh5bjNtTmRnYmJYaUh3Y3QzVi9QVUlVS1FNNmszK1dq?=
 =?utf-8?B?K090NE5MSEhmRk1BWGlYWTc3aTNzZXRXcjE0dkE4ZTVjYW1GZmhaM2R6ckdo?=
 =?utf-8?B?akVLNVlSQjhiY3RhNitHZFI1V2F5UXplVE9ZRG9nUVdRWG96OThrMGx0UStt?=
 =?utf-8?B?aVQ0QjZNa25LdUlYY0xIN0VKaDZyL1BCVEhFL21ySHlJUG9KZlN2SXpwemgr?=
 =?utf-8?B?NlVkaUlOQ1M4S080TFZEblBlaHpWbmdFN08xUThWRWJzYkFpYVpaNk5abGQy?=
 =?utf-8?Q?zNZr/hfHY4iRoZKB0yFet//hLUNmgdZRYhyuU6iv1pRbc?=
X-MS-Exchange-AntiSpam-MessageData-1: lpI1NReb5QHtZg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b615fbc1-cd81-449b-7cd2-08ded0ef3625
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:18:16.0252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF/c4q/xdgKAeZ8mHlT6nqDJxk70ygcjiypNw4f+L53GivlDQ8I+wzB2xu6EWzptWm2CRsE7ljuiqnVKoWpwnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662
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

On Wed Jun 17, 2026 at 8:48 AM JST, Antonin Malzieu Ridolfi via B4 Relay wr=
ote:
> From: Antonin Malzieu Ridolfi <dev@nanonej.com>
>
> Move PDISP register definition into fb module and update register
> visibility.
>
> Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>

Pushed to drm-rust-next, thanks!

    [acourbot: fix rustfmt issue.]
