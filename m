Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A2FC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F6410EEEB;
	Wed,  9 Sep 2026 06:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oBbILicX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB0A10EEEB
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4P34cqxPWPEqUQCyEKEwIvy1HJwSNNCxSxkdvGhInn/ZWYLEnEzAOjX5p3MnivLoRzbKofugyM0PaMZr2amu/1VbsxhFhOtBZMVNH52OT2dhfPK/9lAb4Yi04cFtq7Y3+/OqbIYGRACqhv9PoLUy/SstaXgq2B0nqnF1bWSx9Q8GNLQL+dXhZnfv9QW+qrTL2htbVmMIgOzp1zXyY9bpFfIX4JuoqLj1dT8ofRLP4MjWfyU+G7HW76D4t3//Rifud0OXVx/3nwCbAU12T4moEdnIW56JjbC+pCbyzjaLEhirSLmgdTGWbQcFAdgVh8rbcpTEiKd1WYLy48j7Kz7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LncKFFtg04Zn8+zTgVlTCJhblEiCVJLo/0dSFmAGBgE=;
 b=PhaxLzuHkyODGhgKoarTUxartHor03O6zNW0FPtyprtxJsoB5L775LddmQQKbDSKbXMCQIooFoWIWbhv6IdYMdmnoYD9UarMjwVFYhjj1uThNCp/gsr66l8NIAps9LhbCl2K+4J5q/0H2cDDbsWJ/+PVCn1W4dbz3Z5HGVq+4wKcya+1Vavpl+54L3/QNCuguwYE4Y+0ciBf+7WPEjxdDsimD4pwBrJG37CSP3LFA/twB/f67KnpAJ8qPTSlTvbyZh36lRTIxloTxctQHvc0B0KAxNGqpEFRkUgJ4sYSKuR1WwytHwvIFOSuH5Zj69L74ktq1ppybp+Romep7X22Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LncKFFtg04Zn8+zTgVlTCJhblEiCVJLo/0dSFmAGBgE=;
 b=oBbILicXK8RPxsDNBtPCxWRrGoEGgb0eblD5HZ7PiV7zs6Gf1jkT9O2U7TgaPJcHg3qx53+Hbernl+HdEIKv0cSdbAkQ9aX+ZwRUurfGo1qmMYXbkH0zaAIPUhZDIqwsJ7tkjd7SdUb9fBJlvIp8guI/e+4l0UqgFfib0X4cmO9Kmy0b6ideR8sR/fpXNxc7LbnuX+SR471pKjePTxiJPUW5ZblAh0LNox95LIgMrgfoOSMNxG0mk4puwkT7GshZHYxK6cnqffG82+tv+/xFhMqrrPsEhYV90mRV07m+WXIE1B+NeO922I9VS8Gf+KDkXQk9rn3yNaeWoVokKDQWtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:47 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:47 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 06/13] rust: uaccess: add UserSliceWriter::write_truncated()
Date: Wed,  9 Sep 2026 16:44:59 +1000
Message-ID: <20260909064506.910162-7-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0021.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::34) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2ba593-4d80-4b47-a2bc-08df0e3dfa92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EiMFieV8GhFQg+4ifKS6ddviUcGBDTLyILhDirPgP6lAiC4DrN8tw1MP9OOhRRAeN7ra4+y7ZHj1AaXbKzHSvJCA2633YBF8EljuOWiS/8mwr/gINsXWnASKCp1iOSbaL+ioAMOzD62SOytxclGBBNxBGVsc8/SfdsivlMmG1Q61zpwE1skZPVwzz+pKYFpugFTVym/CvX3ijTecd/iO6nWsOG5ULYWfa3QSTh1ls7QFHRGJuQk445wTciMtRZcesQgspnIGslxrtQ8EUBIqAFVzebyVfOmQE7IufwIUGPs0unq6gqjSdE8fdZXj66yFFas+Mr0kzD2UGT+RmbTAaowvvpIJ2K8+9XhxvFlIju1VKprS00rEuN59plGJj5p2bGGuT7cOO25M7whHqjJsHzKwYA3/llAAYvGxkwM9a7ZL3ulmypqN2tSjx3cRvbhJctToY554cwI8+Y7a+vTuqz4vtTyaYjsTaynB2yX3K0rEgZam9H0WPorIqzBn246GoiH847EdsoNSTWR41kbXUBV+JGWOAoNzVjzWGLV31dbU47nMaPm501eeEcd2v2mCWTz7Fr9jIIhKOTaKQnI8Uf1BkamJrYwPpI6e6ji9DlgpslzAbdXaEIia/7ZTO6K1SKnVeswa2ettXDKIiWGxqeFtq6K6J9a6PVFc+SjfhGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bS4u9zEFFb1ynj+QXHn5OGNhi3mQMfl8EB0LPa8zPuG4BwAqbz9e74zSupqt?=
 =?us-ascii?Q?7sXMUqJAhWmt5wVmB/ayzSNarKHLFhPOkuwmHIvQqRg2vigPBDSlf8ZYYhOJ?=
 =?us-ascii?Q?2IxgcKNayFiHfmfT+tRCMtzwUKObdzKfLzQcFwHobCP8dghFVjDDNH5dTNV9?=
 =?us-ascii?Q?Gwc344gpYlXz0H+Qr++5rMRFvo68NUZJcJBhz0o11MJdhfyNkT3HMYkw1w4K?=
 =?us-ascii?Q?xCVM7msSimYr1KGbFb3plyaeMlc00a+iYg5JiF4P/hfvhhFNinPyP2uinwGI?=
 =?us-ascii?Q?hIU+44ERtE1qf6f8S34mIc6L9gj+YPxKbdE2uAyGBHzGwCqi02qxvnyqUPhs?=
 =?us-ascii?Q?7UHvVCSiGQz+kpvOjXK2VDtj5iEU5/QB0sgUG+43WKopAPPBvQqOiwYU19yg?=
 =?us-ascii?Q?vx8611R3zJBIAKmQYabYK5FgjBHJnZTrTp6gN3TvAR4vT6zcyPjI7dzPLwui?=
 =?us-ascii?Q?goYlkQFCfsxf8J5OFGK9yog4n85qW4QcVsxFN58iQlSDVKLNwCbPASk5lJcc?=
 =?us-ascii?Q?lWN2wd3hihSvAUf50j2YcXxCfn6lKVCb6NVuAFA3DSf7kZz2oegRtRsBXApv?=
 =?us-ascii?Q?eOJofFpJCfSq6DnjxVUtILsE6Adr0UrCQs7n8Z0Zh29tDYXbbbfeemrnc0Px?=
 =?us-ascii?Q?x9pc3cF+ksLgQPGqllAWRDoDsZ14V6AmAYdBrz5BtEMvdw14WSa0PVo8+LK7?=
 =?us-ascii?Q?PdZwzhlCxAnFWSLpv5wpz1g2D8wumq3X+jtZHc3WY0aPU+pzJa2z+ql0rd+H?=
 =?us-ascii?Q?GhZJXyT0mZOdu6re7U8U5NWzeFpE8xIp+Cj43k/gQXThXOmosK1VVXp5J7OU?=
 =?us-ascii?Q?usNddvl7NwG765uLpYUWeIiP044v7YKvqrMJQMJ9ntZWEGBU8zDH8xaT2dl/?=
 =?us-ascii?Q?lLe2/vkusB98+smSxLvx43lox1+6/3w5YQRz6JdZtuOzqDAc0WrzdRgx8p75?=
 =?us-ascii?Q?bO0F4g6d4mmew50+q4gHHEtFAj6lr8GZuIK1XByLjpTAc9LDyW8caMHysBDl?=
 =?us-ascii?Q?ufqbjVui6xxxlZMUgsQwyTfZrTLW8nTdMPTZAqhWA7d9UYbcVbJ2ZTF10Mab?=
 =?us-ascii?Q?5JYVhauH6ScQDAV0Ch7cmt43YK89xDaWIrAiXdtqwzelykV1MVKjaauMs8MK?=
 =?us-ascii?Q?9BSJA5HvTq6RF/All6NKTz36PLrmtj9Epmkdn+pxNXh9mKSK3DzAqCFaX8+y?=
 =?us-ascii?Q?GBMN0uBebcqC/c+mhsXlzpl3cXmHYi9EhFq8H/JeQCJpEX/mVthc8w/wuQUQ?=
 =?us-ascii?Q?zJJUbMckLaqhcYTlJq1EUh6CkGN2EnWfPMcIyAw1CwynlwmSnJRfPG1He+Eg?=
 =?us-ascii?Q?VfnyOiEi7eUVzmr6X+6Q+2JuGqb77Mi0zPkmtM8EFuREuPDijUPBM8i1/m1B?=
 =?us-ascii?Q?gFb49qRwRbaI0jlcCbsO5hoPdImq+m3BKvK0mrJoxegSDJQdb49BJm99wpV0?=
 =?us-ascii?Q?TKnERpHVQVbMpfCfh3VD/hwMiykG5XvfYrd5/BDCg1L0cPG+d4pkSl6AJkHo?=
 =?us-ascii?Q?J5yBob/KdIxgck/lSAdltC1Jo4t4panpNrSNpVJi/akQgg5h/5hg5Aa/HvHs?=
 =?us-ascii?Q?lnGKte/Pw7U8SjqGVsjIXHZ16fwXJJdVd2SIQeHWe1yjbwW//2wZ4roQXEPk?=
 =?us-ascii?Q?/lp2jmqRhsOPjz38MJqXIC5ciGby5ZJAO0/Z8/HpGoUnXPIsVzYjeupfZSKz?=
 =?us-ascii?Q?j7JDvOGZSamSUpwoMMG/mQD25OGAjlfrvqJ5mUBItSOKPsnH9LsmA3h0GruZ?=
 =?us-ascii?Q?ww8Xpf3auA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2ba593-4d80-4b47-a2bc-08df0e3dfa92
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:47.1430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLbnuYwTLuOlb1EhNYqMg9rvRwxy+G2pA5hqn3HkTzJclgH0pxHbfrA4mAJee8QuDcu1DsNEGe3nRJ5O7huMIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

Add a helper that writes as much of an AsBytes value as fits in the
remaining userspace buffer and returns the number of bytes copied. This
avoids requiring callers of versioned UAPIs to convert values to byte
slices and truncate them manually.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/uaccess.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 5f6c4d7a1a51..c63b91942631 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -624,6 +624,20 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         self.length -= len;
         Ok(())
     }
+
+    /// Writes as much of the provided value as fits in the remaining buffer.
+    ///
+    /// Copies `min(size_of::<T>(), self.len())` bytes to userspace. Returns the number of bytes
+    /// actually written. This is useful for versioned structs where an older userspace may provide
+    /// a smaller buffer than the current kernel struct.
+    ///
+    /// Fails with [`EFAULT`] if the write happens on a bad address. This call may modify the
+    /// associated userspace slice even if it returns an error.
+    pub fn write_truncated<T: AsBytes>(&mut self, value: &T) -> Result<usize> {
+        let len = self.length.min(size_of::<T>());
+        self.write_slice(&value.as_bytes()[..len])?;
+        Ok(len)
+    }
 }
 
 /// Reads a nul-terminated string into `dst` and returns the length.
-- 
2.54.0

