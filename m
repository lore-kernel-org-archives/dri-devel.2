Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9E71088E64
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FBE10E7EF;
	Thu, 19 Mar 2026 02:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ENo/rMi2";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5377D10E7EF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyczQZHqpM3TttESmZv/OTVvR12MAAx5fiQP7Rr25wj9YlRDpQ3FJTlWXxvvt7B7ggVdYGk5i3qlf9QY1/JwSOzY8SdMEUYKiRV6g92ImofZOGYfOkI3sy3RUw6JGU5flY9LDNcniQgIOJzfYID8CmMMLzkIfdWJT434pmsHUW2x33FNwkkQL5H3NrYd02T7B7dC/UNVM6X/KJ51VhJEccGTZsJgx75NikAzUl6HnrE0H0X8stO7nO7btvE+mhUdc+T9/QydB+zklkP/SNKedWFu7q2QLKsMzsyVLZYdxotUQAUgSZIgaXrDyjpKePR5iQ3bSCXNThlDpbGqy+wjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Po1TSVNMYuDpNe3PF++YmaHlE4vlQi2agE7CpXy8kQ=;
 b=AM1BTb+l+cVPi3cHszyzFatilXVmuyqYXcEnXNtncbJdtDv3lIYlhpC/06T+mgohlGA0E2Sl/pV1z8qSKUxA6XURLR0wxBGLd70lhGQZJqtsQWyE2pBRtfqGN1tsIKfTGTuEO0GsZiCs57gZIzneBPOZvqP/X9DE2GHC045vNUvLkIsT585O5kV5IwmoCo8Vt2yJe+NMHR+Q5L9OYJL1nDETD97hE8nrzkxyMQ9JLAxJJM8fkqfQQwMO2X+j0Y9EqMDtA2XYKfhuHkRYBhf4cJP5Kr+DKZDYSZKufLUUGgtcqnGlQBDf6b8ogHaLER7/Q5+VfFVrw8xSdx4h7dqYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Po1TSVNMYuDpNe3PF++YmaHlE4vlQi2agE7CpXy8kQ=;
 b=ENo/rMi2CakZNZEISmjnN5rHBbx7Q8Y8WpelJd0xZVtLIXCgpygBIQJ7+oB8nhUidTp0DpoQy2YuaatguamismUENilSjy7B5ZQ8lAftRqw/1WMwxpC0yFM0RXNjLTNamAegG5yl+V2NCFHc68SucxsIX1EOk7no57JJEGmpCjy61fAtzYu6Kaea0sLnVUCOXwoovuF6OFMG6cdvAS05my3f+cWCHbRvSQkqO5UjaMuuRPGRlVK0TXreIEv65Uqoru8J/ukkb4X+pj5Ua6v3CxKXRfUoF2hRHiXyGfovo1FP0g89jg2oaOZoOUGKawD0Soxr8q0Rxhc4JusuWhzKgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:10:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 02:10:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 11:10:36 +0900
Message-Id: <DH6E6UW5BKQP.1Q7H0X0TM4WZL@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v5 0/5] gpu: nova-core: gsp: add locking to Cmdq
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
In-Reply-To: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
X-ClientProxiedBy: OS7PR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:604:253::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aee20d4-1c7a-47b3-1dbe-08de855cb7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +x+KXBO6ZuovdkZeDVCtXT8fIFEsVNW2BNcPexBwqkSWm7etTXSH/CvEuElp6dR7RURFzMwpY9idtGHBuxLjvBdGbrKjdH7boUVBRKElKOszUE5nJt1g7tyLFCevrVgKCNd1utif5PD1Pwp3XvJLnf+N+dYMsrD6Thk92kz4rn2yn57xnZ5hzTxKtzeis07yJWzLSTYRpKgGOCofgA5Y9de9JQKTK/4Q6mlKIGnDZOkOPS59fIQLOQd0vEGcNMGuKZ8xZeww1oddWfye3WsS1oqrVYX41ENwUxjF21+maQFT2C4dqV5haagpMAUfpDy7S8sydQTjO+yHXCVDztSwnEN0d+1DFZ/D5p/2axwqhDBi01u4FGBVEocZvK5FKAbHVsm3wqQ/syYFydAgkFNEULg9BwH0J7xo21wAFAxbvkG0jCyiOIE7vpJLO64nLlRIQfxyjoTTEq7SrvHHoK/3AJBxnQqd4ZOgXfZsjkOOTrG02koCbIZdQQOKNaHz2Y/JSP72HGJUIWe8YXvesh8ybc8/ClJ1bwXiQwf4DscsVJ6bILzUz5RLHapskzh/SFb6p6+y4sfIi9ahobg/vUuWImClhlsh2SPPxYKIp3xw1ga0c7Yd7qY725iBcGMAupPi7LIqsfcBTXWxEuv25x12lWhaMqboS+8e4hvxCawQZ7LluURX8H24O9HZZic5VcSy/laKDvQ8kg9mRPN2i1LWHYyFUBdtR6MSjPp1UzAZu8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEp3YUpEaVVjYUV0clhWczNBN1FScnMrbWpaeC9nN2VnSjU4bUovb0MwK09y?=
 =?utf-8?B?WnEwanhhYldIeGRFRlhoZWNVWVpnK3BQZENwN2htUVM1L2c0clV6MEpidkd1?=
 =?utf-8?B?ZTJPeFVUV0JvMEVsbWkrV1l6dTM5R1NJZGVqU0YxV2hvTVJQOUtqN0VYVXFN?=
 =?utf-8?B?NCtoaTFDQWc2OVBiNU1zdHhZcnZqODYxVW1HYXQyZVRVaUs1bkZmTk0wVGN4?=
 =?utf-8?B?WWtQbzNuVW95Y2RjcmpPMHhtR000NndmL3E2Q0JHRmtIVVdTYVRrQUQ5SGEw?=
 =?utf-8?B?bHhyKzBPZXNldFdBVVhGWFpJUVp1a0YxbmdMbVJYKzRvNHFBa0UvamVLTWJV?=
 =?utf-8?B?dTAwYzhoaVoyMWVDTTZQSlhpWXI2SWFXdUlmK3crdjdOMHhDczV0WTZLdFVp?=
 =?utf-8?B?dGc2L253dDBnNDlZa0toSS9YOTdXRTI5NzBJbXRlSkxaeGd6S0Zlbk5CR0d2?=
 =?utf-8?B?ZFlvbTlZWlRqdjBKMVpiRlJDTEZlSVBTL1Zva0VyWnlLc0ZPTE5IM3pTcGtH?=
 =?utf-8?B?cm1oRjd5L2ZEeEczM1ZVNytzTzZrbmcybFRyaCtpVm1jRGhWeG54L2xTZ3Jw?=
 =?utf-8?B?bEJZVjhhaVRBbjBLUDJ6bXZtR2hKZ3NDTkp6dW50RlJZNXFsSTZyb21QUCtP?=
 =?utf-8?B?RjhYWmRkWGtsQzJyZGtzMUJqZ1Q2YllNdUpkbHNOeloyZzN4NjJHU0Z0endW?=
 =?utf-8?B?WXppVTFzdFVUSXBvb01YVEI3U3Q2UU1HUjFNTVRwY2ZkTGpMQmZCY3REYytl?=
 =?utf-8?B?Z1l3K05FSDFCR0VUU0ZCT1hrVmxGUit1ZG5MU3Z3aExvbU5Dd040NUd6VFIv?=
 =?utf-8?B?Rkh1QzhJYjZVZmRybTQ3dGhOeEJnZit4a2FLdGFFdDZ6SWVEOW5HL3BaL3Rp?=
 =?utf-8?B?NFhJd2Zxd1RraFR5Q1p0T0FiR1FlY0FtQ2lyTFFCSW9BQXJacHZrcFQ0NXZG?=
 =?utf-8?B?K2hDRVp1cmxURHlIVm1oWjFBbHp6QTMzOEhmdllkQ2ErOVM0L1RMUzlQKzZr?=
 =?utf-8?B?alVRZDhvY1FxdHNaYTdOeVVyZWpXTlJCazdSNndFdHArRFk2N2QweE4vdzJY?=
 =?utf-8?B?ajA2WENzQms5K1QwOVpQQmhBdjRtOEtuQkhsa0FlRXBiL2R1czltOFpYTmVp?=
 =?utf-8?B?VUQvbit0ZjQ4ZDF6STE2WlRYamFHdWRpQkFVbXR6V1dxNGFVR2hVMS9Ucnlw?=
 =?utf-8?B?ODJoaVRzUTlrWUovaGZSRjdBYmdUalRjMlpVUkR6Nk85cFN3eE0xTHBJbER2?=
 =?utf-8?B?eTEwYWNPcHRBb3dzdnJ0M1pQWjZENWllTnczSlJOZTVrMjRuZXBWaGIyaTBL?=
 =?utf-8?B?UUR0U2tJMWt2dGV1OG11WXJmcnVPRmFaVGVFYjg0Qno3S0NoSFdnL2dYZmNN?=
 =?utf-8?B?VWlaNXJPQXMxNzJBSjN2RlJFbEtvZllQekdkekdUbDlvWHk2bVFRWWEzdVVG?=
 =?utf-8?B?bkRicmJsRXM4NmdRckVpWkZhSGdiVWdYOWI4TU1YWkdQdXJjK2k5eDB1WStK?=
 =?utf-8?B?UTFCa0VNYkkyZGxEN2FmSTBPUmRWZ25BUkNuK1VhbEJheHBuYmR1Mk1SZWxm?=
 =?utf-8?B?WHF4b0JkUkd4ald3dHd4S3lsRUFrRzZkVDlzRXpqeFBHWURjTG1QYkJxZXdr?=
 =?utf-8?B?V0ZuSHR4UHV1cUE3aXFZc2pzZUtjMVcvajd2L3hhYmFBbHgyOGdXUjFjUGk1?=
 =?utf-8?B?SjVVclBlZGRCMTg4cUFiUERtcVN4VC8rNkVWRE5XMCtiVmh3ayt0T3NSUFRz?=
 =?utf-8?B?dFU2QUVINmxkWVhsZU1EaFd4eGlZNHVFVG5waFI4V1ZwdWVTd0F2aHM4QUgv?=
 =?utf-8?B?OS9mcVRnbFdNVEFUdjdhaENmODBmc2FtZmFjbGV0LzJLeTdWU3VIcWhBYzJo?=
 =?utf-8?B?ejJKUFdmdkZmZUlZVk1YQmtUUjVGamUxNTMrTDZtRmVtRlA4K2VTTjdDQjhk?=
 =?utf-8?B?TFdFbnhkUXc3UElhcmVhYmsvTjN3c2Z1Yjl6V09UNTZhVUQwdzNrZmJYdzBF?=
 =?utf-8?B?MUsrMnhYRUFyZXplTFgxY1JpajhTQkpCNVgvTHA0TVpENjloN1ZRNDFqaFd0?=
 =?utf-8?B?R2xSalFjd1YyQnY5NEFVcWpQMmVGT3BwQVk4bXNTOWNOVG5pTnZ6ZkRYSkFj?=
 =?utf-8?B?ekhXR0FkK1dKa051ZWlzbm9ncTBmLzY5UlAzVTJmTTNKMHc4bmQxMXBNbGpW?=
 =?utf-8?B?NzhQcEZjRXR5ZytUL1VkTnRhUU1Ub2tWRytYMHRtTFdxQ0NXbXp1NVBYWFhq?=
 =?utf-8?B?M3B0aUtGSmhua3BtUXFZTU5XQTNWd3p2K3pDUGNVNld5WnlYT1ZpdmhLT3oz?=
 =?utf-8?B?SVBKbFA0K1pOWkJRampvcllYZWdsYjVJT0tXUnlVdC9Hd29PVkdPb2VPTHZH?=
 =?utf-8?Q?I99WNDptwE0itk7oBMFhgQiTck7RA2+TVrAKVEfkNzcJQ?=
X-MS-Exchange-AntiSpam-MessageData-1: gZul7UmrCH5Lfg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aee20d4-1c7a-47b3-1dbe-08de855cb7cb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:10:40.3718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83zZ5KcryfhzfRWWOw7D9nCXQ91an4WwGEcfpSPxe+1VyUlJQYkhcjRMakIWxl32Y/8So46hfVfzHRzV1974/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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

On Wed Mar 18, 2026 at 1:07 PM JST, Eliot Courtney wrote:
> Add locking to Cmdq. This is required e.g. for unloading the driver,
> which needs to send the UnloadingGuestDriver via the command queue
> on unbind which may be on a different thread.
>
> We have commands that need a reply and commands that don't. For
> commands with a reply we want to make sure that they don't get
> the reply of a different command back. The approach this patch series
> takes is by making those commands block until they get a response. For
> now this should be ok, and we expect GSP to be fast anyway.
>
> To do this, we need to know which commands expect a reply and which
> don't. John's existing series[1] adds IS_ASYNC which solves part of the
> problem, but we need to know a bit more. So instead, add an
> associated type called Reply which tells us what the reply is.
>
> An alternative would be to define traits inheriting CommandToGsp, e.g.
> CommandWithReply and CommandWithoutReply, instead of using the
> associated type. I implemented the associated type version because it
> feels more compositional rather than inherity so seemed a bit better
> to me. But both of these approaches work and are fine, IMO.
>
> In summary, this patch series has three steps:
> 1. Add the type infrastructure to know what replies are expected for a
>    command and update each caller to explicitly wait for the reply or
>    not.
> 2. Make Cmdq pinned so we can use Mutex
> 3. Add a Mutex to protect Cmdq by moving the relevant state to an
>    inner struct.
>
> [1]: https://lore.kernel.org/all/20260211000451.192109-1-jhubbard@nvidia.=
com/
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Merged into drm-rust-next, thanks!
