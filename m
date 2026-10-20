Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2A606A325
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Nw5TEhyN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8A710E26D;
	Tue, 20 Oct 2026 18:20:40 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4583910E26D
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 18:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcmyuCiPX4Jk9SWZP7Z3GkzeEFVTYBNKkg1nwwMZCIbJaAc/7OKqPLQnkmIOYN9/KblNxSwrqBE3urDkydSb7h+M5inFt/Yf7tH3H4T6bhjFWV+TgNSr8c1KVRSlrQQkfJAIjdHqAYG28uIwk0+D7DNtsz69z3KSVoSDQrtuz1sqwGHYSGhE+dsLJIH912TgIEuvngfYAh2Jjauafv9xtk8eIOAbjUcfgoePQNvocjUTvoEQvOqiypDqJw+B7P50Xe+shtDdvV9Baubm3u0TkCoQFBMpAuXU1XgtdKu4CVr6dRFJy+3nIMdGXWWX7MksBhNmFYSLfvpVATNc+e6Diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL7QWmo3ZUgPZJpZm6BtqmZyeRnpALI62uWLTk+NGjQ=;
 b=RLhw0O4wchbWNGDx+plJaG2aIS8sgGYiKr/mh9qPxGSWmq8NCD2tjBpL3gL4orTDYjpd/RMmtyqJbmbkjrI0CkqC6LmdyDavXT4/+GvMbePR35tHJLA8Z56E5txGcLhC42JHc3jid1fI3ZNXVSpqQq1oTuZ9jj+z1/lPu+mr4uq7xhs78ln+849HJ1Pcc0dim8m/Z/yHJZruv3JEW7BQJ048BdzgQJzhmiCtanzTM2LU/qOgLRrIbJdQsjxvakzdgm6lMCehwVjjbX/RkxQrOkCBVZeuTd1Riqs7EXsgKAQODV9+Y/KEouezW34O5ZG4s6Ze3KPaS89HCVGk1vaYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL7QWmo3ZUgPZJpZm6BtqmZyeRnpALI62uWLTk+NGjQ=;
 b=Nw5TEhyN6WOQ1HyQUc453WhsQY+FANAyD9Z9QdIzgR0mNTQK2kIunTNdOfAz65P+35h7K7H5aj38vdjUPVzxSpSAnuhT11BCs1V+SAe/1VJXQzjxby4bRFFs852GAkyWGYmgvhHMJcgO3K4exNBwb4GffVrCwB3lQbaVQI25WA6bShAElE5rvDzGtSlw2ZznvuuNE1CEI8dWupckiqAWBH9zCeSxfRfY+9Mx2nDJ9Tclc3mgVJh3jxRgys6seLWq/+aKd0MIuMyss+UhTP5pWUd6YwEF//VGdwvr4VjSR1mo/xN+4yTK21MkY6oz9aMxsmy5vLC7NUcvzq6beAI90g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA0PR12MB8253.namprd12.prod.outlook.com
 (2603:10b6:208:402::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 18:20:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 18:20:30 +0000
Date: Tue, 20 Oct 2026 15:20:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC PATCH 0/6] iommufd: harden DMA-BUF PAL setup and release
Message-ID: <20261020182029.GH3008132@nvidia.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
 <atdKZpEJVZY0enR2@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atdKZpEJVZY0enR2@nvdebian.thelocal>
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf72785-7a1e-4985-0ea7-08df2ed6d2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WaJJz491q/5sdPK8zoBlavkTOIVPYcVm/fHXZpxG3Qum0eTyqNH1AQrPRcie5uhTNkM5nDFcG0xW/8JibIW1jWZ9z5+3LchtEKANlEopOC2N9/yJmM3/lzgMnSnTe/Ea6RWelYj6ETD/J/+IEm11ISJcfPSS8Fh91Sw4srt57HwKCPuoT4/IhoEfF9gZiXV1R2OtLA2PlZ82KBfJws1+zRVIm4v/Jb7As7/bj+i5yBHnKgy5RO1BiMSFQBzVKJKGfHTIPD/LHDq2yru7GS5zzNb3k26q9xnehZCbFp+Sfy87QEF+07n9AFcyY7mAKVX1jcOlRXG3PmXpqjZ+IizJ17mVN06LwboRXgp4gfooqcUSAzszq4Ab9ew1pshF5XGsLsCssFtrjF3MVyiic5o27T0iH8uB27p9YJnuRFpCJdr7dX91C2C4Zx2IFDeRsAvxbvu6+CJQR9NCJTrJw1F5PTtOf0eIOZo9WqR/m3p7BHVNFpGH/1OHNL1LFc98jh8ZNVmkAEGUSABVqeBndcEVXJdgHMgzQfmTPJeM8IQV9TXL5OshFiomyb4JaODEilXSv7FRX3P9uY/O5Uv4NE/2JMKps6BFcVSBDPaY9MNPFy7PtP9k0pDtRdf4WcCjTtJmq8zcbSa3G8E+x1e3QQccxt6ys5Y3P7uHiLE0NqekuQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bDc60YnkifBMVKmH8OqFdyP0ZtZD9luMDHPLgi0aXkhg3XVwwNb+XrbXGZj1?=
 =?us-ascii?Q?Mi3jW8nrNPy/wjBxORswONgSwJsvHNrF+weL0XQXp694VTtolnW4anWIeAX2?=
 =?us-ascii?Q?kg/XBH1NEkw4VUdMfRiffidccS8QBUlJrcXVaLI+ROHDxAnQ6/u/Sm6ta1VK?=
 =?us-ascii?Q?04hH5Nd6z+OTxyG37J3yukmKLy24bnzJFs7pu2mvYEv/H/LQ+qXYOhF0xbaI?=
 =?us-ascii?Q?h46ooQM9bGEUXA7v2HKavOwwgIHqCxim0gfIQsEPqjNW8OFHiQOGT6SAg/yi?=
 =?us-ascii?Q?e4H0EP8oojjZV1w9LP5dTn0YLwFasnGQNjsg3aTV08uzPP51rgKZZIgqbi+w?=
 =?us-ascii?Q?+6m+34xpxoEF1Dk69qU63PwuRWlVQYlWu5H7kVPXNbtZcsA0K2tez8Sb6xpp?=
 =?us-ascii?Q?eHjs6Kb9glkIg09kpRwqfue0IzAXZNb1YT2I70OdRa+sA6MjWyrSXyUGUHLK?=
 =?us-ascii?Q?wZ4EVxcmk/JrhP3XM4JU+8vw6WbLUr4YoQUObEjyw5KEuqUCMdu5UXYueIex?=
 =?us-ascii?Q?MNcV7vypE122UQArzgBlwPYAEhrkVG3uf0CgRC2tXKbKH861MnLxfANOE4VP?=
 =?us-ascii?Q?0MW11dkszFDOx+LKGcSQgaJnyXqdG458YKkDihl++wYBaMwNr+Rp4CVSHlFq?=
 =?us-ascii?Q?npUMetWb/+gwTUd5HOsoiIsNUTP9P52slTv5wojDMaawUIsSxNfDTGmw8ni0?=
 =?us-ascii?Q?DhOV3M3NwzVO4rz+84Cjgvi6kBm9T+zlCmdydwPCZIKm2KxQBS2U0wkBayy7?=
 =?us-ascii?Q?HDm/3CEldAPAAQYCqrkrwDEr0fLF1GR38FHezov3gVFxF+PQo+bipXeZ98xj?=
 =?us-ascii?Q?BNN911eyzTlZplUaCOAPKzJCayuW9omPk+EQv7iRquU9SnifjFYyn3imap2a?=
 =?us-ascii?Q?XNIsZF7RMrOAts7spvfJf5wZFy4H4/HS0+CTElzmOZWd7m0myM1jDDLHmV6z?=
 =?us-ascii?Q?eXsBxqmXoQKx5K12WPia4IuHX71bp+z7Th4czh4ChuX6B9LIcqAYBG1tzpE2?=
 =?us-ascii?Q?SEar1zHAK+tf+d525ayiWM3vVASVmooSqegigU8f1Jim9T53xpe68XwwJbYL?=
 =?us-ascii?Q?wAJeIPpVpV54l7pnhBb+WQv5ahWS3FoCGkQ2gv139nq+WdJom0v2s9hXABeX?=
 =?us-ascii?Q?Cyai3SZAqo531tUwxJq+nsPhKNebpHiP6kyOlt47ovTC360f7wJUJ6Ybav1o?=
 =?us-ascii?Q?ta3/tqAXMu6x7kldQXb2OBCHXiFOtrlrAHwf/Cnc8gLMTAE6xkPX9yZNBJn2?=
 =?us-ascii?Q?iRMm1tOjev5KSqxXzvzxm6M34l3e7SrlzcFQkzNM5Rls8iZZWzVU5yptMs8x?=
 =?us-ascii?Q?m0Jo6GWTuCEScXLt0No3ydFApc8sex+X4eqzMam1Cd/p0opLLYI1hhCz23R5?=
 =?us-ascii?Q?IgO/KyIqVGOKxQKDuVNcGNXjuyKwGH9lqAfQ43fWDRTmllVwcafHxfGTNiaZ?=
 =?us-ascii?Q?9uvDgeby2LLbPRCApLQWOHBG7nuTZnpNYPRFUYl4osUgWyTOkUuWuLxNbVSr?=
 =?us-ascii?Q?BI3DlPDctRQgFLV+VzSPkgmLAMdxE/AzsXCAKe8yv0OAAlvQ2aERgul7nuPV?=
 =?us-ascii?Q?9irONHaNP1QEuDwiXI1dLXt3H5pl5GT4ItqjsUd/lNTl39maagB+osdYgfeR?=
 =?us-ascii?Q?hCIJJy8WlP5eJZjMHMht8nyZ+RzTZSODXKhk1hzV5bjm4k5F72RTaw5gwX6c?=
 =?us-ascii?Q?M8SIuBw+zSPkFkl6zI+YvEqKxZkoBzu561JnHimCVbkSob0c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf72785-7a1e-4985-0ea7-08df2ed6d2e7
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:20:30.7126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvlkmYvOtLtDxlsiIDDCvZVxTj8I0kd3Vf3EtCblVepyOp4FnXDjZBOMz2/iE4RP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 10:16:26PM +1100, Alistair Popple wrote:

> I haven't had a chance to look at these patches yet, but if some of them are
> fixing bugs in Jason's series it might be best for us to fold them into that
> series, with correct attribution of course. Anyway I will take a closer look in
> the morning.

Are any fixing bugs in tree right now? I think one of them is already
applied from someone else..

Jason
