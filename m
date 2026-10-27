Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346860A2606
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LCVkFGBF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B0010F279;
	Tue, 27 Oct 2026 07:36:08 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFFA10F2B6
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZ41mEIE04AR7YlkawrWBO7VvzIpIWyJc10jMQ969oQhsWrS2vnIQRUgWtoBibMstqX5Vh3mDHWUv1QH0MJXcybkZ+FHgEgQJmbBk9nOUaPS/mbRzmgE83uewcxHNdpbWjFgA/lUU66qa351/IP5iu8gCA976NBw7YgIi7OnlOddiBkSiiD2itl4T/4Wng4gS0G1m8SJNUG4QL3mnYr6d7RQ/vcQRe2Ft3fmlPOn3ZVgumP06NfsmkEkeQMSTV3F2JcF2F/DRw8oOdfWC/X9c6DrZnUfWn4or0R58la66aeQB65yrZhierNcUrg5yRrUWKWkvWiLcApJ2gUrq111hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRvAfzxpZKSzBB59Pv7ofHNvhG/+Wabw/3inupPPgDc=;
 b=wsqSZABaYhg2SY4lz36jHoFp8YkCLxuPszjy5LP7EHPW2BOkxpN2SNNc2B1Dkevo9VsR/m92TNrF3YzZvg/t6u3dbZLWqqbPxCsKJJptjYPPUiBdJ7gThXDyeOuApXNNlfflYgfDq8xF3f3ddVs79+LsDDZWv+zOoURvbA2cB5gHseJZ/An0tKLCHHoeIyOnguoV7kr9yee5t5Ppf8fA4skYpFY8BxEIDMb33DCOoraAqJsn+h8yaXlRFo0vJSSAw/AVgRqnSjwNVBxHp2jLTeP1krv3JfuzLcjlGqbVtARzUkVfpiNlGzE3cqFXYnf0FuZ0Gn4KVWIcwjZVOZbPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRvAfzxpZKSzBB59Pv7ofHNvhG/+Wabw/3inupPPgDc=;
 b=LCVkFGBFyURAIbIGT71s23aa07WCqou2YuOeX/S1GYEDAZRVfRIYtGIHf+WjB8qTw5VRGn3TMKnFne+x0FvLz+TeTvkbD8Nl9pPBzgzdg9TZvlz5DxgGKU7renZ3juP2sHcuGlPHfkBbnvEMiKTUrCsLar+5Zm1FVLvlwKLZnnmS7mqZ091ynZ0/Rm72TCUdfmhL37KsBKRc+NhW4K/inTUIAshXkPKcAMHwT+yRX5+pv1k+PJepWLDnfrH93C7LPNj1CugEJCioO+wYMMG52CJC5FTH5PgeeVf4WlopE+BdumoUzaw/KTFZDtdGcGiwtC0Qq6bI9Kt7PIqYjLjK6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:35:52 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:35:52 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:44 +0900
Subject: [PATCH v6 01/15] gpu: nova-core: gsp: cmdq: remove stale comment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-1-bed9669724ba@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f142db1-db39-4a99-c49a-08df33fced93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|56012099006|11063799006|261022105027099003|261009223027099003|261021121427099003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: GCBGaWOwhJjuwx75ZdDWmoN58KcssCDfKNOUwcvDfXwySn4ZrtU7+dgIimAqLFQj9OFsfmyPEYo+wHCdsXpVD0Ns3pJ+Qt07/n1FEmAeQzPXtn4JdoUydLP8aBTB6zdt6iUgVEvxNA6tS3jTOb8hsRuUlAPIbZKTKz5f/W8RUhXa9gEWXtzmK4Q0yF03eqKc42Ghu8n2ddyTszAOC0uqOL0H+u+QsT5K4EfZ2IlWsyhZsxcFBF7BK/H3BiLojeHbnbYFRTi028vfn3STnBQKjBNQqrgRiu4dauuYYCQo0zgcjwRRTfhozf7QhzLku2UpEVSHaPUlvPYlZLaYT6pNi+dbeCPRbprXxaaSq6Q0fPklKixNqMZI5EI6PnzDcHJ6P9Q71oXKtrWBMSyNPTe77vkcYn3/WRFlYlwnNTepwNVolNkl5JI607AXEz+WD17nuYkWYetsJQ5uhvLiWVjYI1A9KAazrGmlG2x0edfQjsi6f5e26NYvxWaCfmV5tnBhqGbkmoie0MCnqBkrDrtCYUwEOe0+mybsmhLQK8vmufAe2iXuaGtxvhDek/6jTxNf7k0imeqhBvH0pcpMcTUsZjqmgnbO5oxgcggGq+LlUS0XuQMRPyvAloDsNsoeEe2GM20hwVosUL2WF5SXvLnduJT4k1NMKxd6yWUDKEdErKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjJlLzdvQ2crK1ZFcmtLL1ZyeVMvbktmU0pCVU43SHpNeXRXblhJNFRHc0V2?=
 =?utf-8?B?YTFNa3lVcVlVdElxYWxFZmt0Ti9FcmVzanJDdmxGK1JLZUI5dlN2dkU3RGgz?=
 =?utf-8?B?MUlRR25RZUdSVXdPT3Vrb2ZvTXZmcmNyQlU4MDM0ZEVhTlZTWWYwVGZrVzBX?=
 =?utf-8?B?TVJiYWJ2QllNUFpWSUt4cWhtajNyWjhJNmc4d2RlSFFSenhMYktQWEJtVjhM?=
 =?utf-8?B?NmZKREptY01vdXAwcUZwYzhTdjFXRE5rbklxMC8reERKbHJBeUJTZ3BMUHgz?=
 =?utf-8?B?eW03UjhpclV5TGpERWhiSnFjcU8vVm9oYnFyb2NaMUtXQStTQmx1MERaSjdM?=
 =?utf-8?B?MUk1WXhKdjBQMlk3NHVIN1JraHlTajRNcHJVemlveS9Ia2Y1eC9jUVhBUDBy?=
 =?utf-8?B?VDB2S2F0eU9WMHk2QTdPcDN4Y1luVXI1bmVZQ2Z1ZXVza0ZRNUhONURabktp?=
 =?utf-8?B?RitqWHlUc3FuOTFhbis0MDB5WTdhaHdIaWszTDRHVGJ2bjdpZzRqdUhrUlBq?=
 =?utf-8?B?bWpYeFFvdTJ5bWhEZWhtelFRajZNVDVpSnVVWG1zaU5ZMjhuY08rM1BRY3BO?=
 =?utf-8?B?cUJVNElQL241YU9QM2I0NWFkOU1TbFA0Q05wTE01TGtMaTRGY2hXOXBmS0d4?=
 =?utf-8?B?NWNVYXlOUFdSNjFwRi9rRWtEMU5IVXEvcGJsVVpwR1NnVWpzcXpOaElobDV6?=
 =?utf-8?B?dHd0bjV6RzRDQWNWWk5UZ2lWUFpMcTM3blJ4QXB0QVA0NmxxQ0ppRGdWeFF3?=
 =?utf-8?B?bm1KQmxzL2V2eFk5cHE5RHlaRUVIOFNveUZTcmFpbEU4ZElaUEV1ZWFWTmQy?=
 =?utf-8?B?RUxKRWxyZ0tuYnVJbmttWEdlbmRTaVN3eUN1MXlVdmE0K3kreHZmOXVxQmZQ?=
 =?utf-8?B?L2lkNHhhaEIvQysvUE5UMmorbTBpb3VMZzllVHl4Q3JXN3YzOFQrRmhHWWF4?=
 =?utf-8?B?ZHRTTzFianM5Rk5CS1ZoSGRLSkpCVm95QjFxTUV1RjJTaSs4ZUJNY0h3Nlgy?=
 =?utf-8?B?YURycTMvUDY4Wnhob0FsYVlYNlZ2alljN2swd1o5aUpRWFI4MzNXSjM4emhV?=
 =?utf-8?B?OWQ0Z0RKRDZud1lGUUkwVTZTcVpia3M1bXZQKzNCU2lsQkVVVnNzSHk2TGp3?=
 =?utf-8?B?LzZPM09zdnBpaFluQkpuV3RYWHFxeENJL0VMd2Rub2lmTkJpU0s4bHpWdk5p?=
 =?utf-8?B?YTZRQTJWeU5Wb1BnZzljUkVLUGZiVktyMW8xUDFCakJobWhvcklrUTBGSkxX?=
 =?utf-8?B?cGtGV0FFZ0Z5ak01cElvVVpCVmRHL1VPSjRTb241VkpGcTd0M0srZkQ5WWp6?=
 =?utf-8?B?VmcyTGt5U2ROT1Boa2JnOXRGMSsxTFdrdlNibTVZMTRNaVhSbUVTWkIrRTJ0?=
 =?utf-8?B?TDViNEZlUGQyNCtnSk9GcGY0THB2MURYMDEwSXQvS3BwL0JONS8vMVlnaS9a?=
 =?utf-8?B?R2NVL3F4VFVzaXdXVTNxZllJcHJBYkdwWUM0d1BQWVRQUzlteW42OVEwODkv?=
 =?utf-8?B?THkwTVdQaGQ2bTFGdy9tQjJVU0ZEZ2o1SVBVQlF1ZUcvSkJ5T21XanQyc2Ju?=
 =?utf-8?B?SUZzZk1lNXJaR0dlOGRVeDNyWTlPenBEQ1crVCt1cGlxL0tyTTNDc1BheFk5?=
 =?utf-8?B?NDRURTd2Mmw5cGhIc2ljakg2Wm5WWWlFY3cvczk4MlB3T01oUVpweVRmWVUy?=
 =?utf-8?B?cHJVS0xyS2FaaDY1K3RoMEt2NFprZ2RiWjhXaEZQZkZWdDQ0aHJSZ205THA5?=
 =?utf-8?B?ZS9nZUtHelNLUGNSNFV2NjJ4TXBCbC93NG0vNlVYTi9OUWJ4OUplRTFZa0Va?=
 =?utf-8?B?VkpzRXRBNHMzSDF6ZWVTNjNFKytYdVNFWWtBend5ZHhqeHJmcjdIaTNvWThT?=
 =?utf-8?B?WkM0U1owbVMweU5MK0RNOEhnMGZOemZKaHlZcnprbDVuaCtTY1JoNHlvY3RS?=
 =?utf-8?B?OWRiNWE1MUN6bWREdFI3aThaZkNQaUxPWDRzYmhtaUM3Y3FHMEs3MWRtS3Fu?=
 =?utf-8?B?ZHBGekRHc2JxYTJVV1JMYnNvWTc2M0VkZ0hMWTFZRzh0akpRb0RzR0tQOFBk?=
 =?utf-8?B?WnVCaVlVQ242VzRGejYyanc0U1Y4V05JWGVseU1zK1d3aU5kRmk3eGwrMGo0?=
 =?utf-8?B?VmtwUG9WOWFWWFcrU2xGOWtucmNBODNSRTVnejYzbjBLOC96RFVLRVBYYTMv?=
 =?utf-8?B?LzJ0cE1naU1kMUxXVFpwZGU4c0x0UHRwblhQQXJjNnJjeFRvSTBxTXpGRGo1?=
 =?utf-8?B?TzVGQ25HYTRheGRsdEZzdVpzMWtQUmxmSFMvYmV2NDd3U2hzTThzQVY5eDR4?=
 =?utf-8?B?SUZWajR3WmNWUjl5bXlheWZuRHJTblIzWDZieW1yYmQ3OUd1K0JibzFaYVE0?=
 =?utf-8?Q?dZEuq3EHLq73sepdLjz0lrVjn0wpKFMs+JqXJv5FTJxXr?=
X-MS-Exchange-AntiSpam-MessageData-1: Dr5hG9tF1fkWXg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f142db1-db39-4a99-c49a-08df33fced93
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:35:52.1733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvw8RGweukAtrSx9DdCoUmOKQw7YvY184XvRfym+NCZEiY7OcqsjURfMKUbRexgabkf438ly3VWRJk5BUz6uQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The message constructor is no longer run by `wait_for_msg`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 1b2f346a237f..accfc1d20d28 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -777,8 +777,6 @@ fn send_command<M>(&mut self, command: M) -> Result
     /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
     /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
     ///   message queue.
-    ///
-    /// Error codes returned by the message constructor are propagated as-is.
     fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Wait for a message to arrive from the GSP.
         let (slice_1, slice_2) = read_poll_timeout(

-- 
2.56.0

