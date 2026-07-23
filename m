Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52FAC44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1328210EFB1;
	Thu, 23 Jul 2026 06:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gzRKZuOY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B14610EFC0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an8MslN+ODqBdqjHPVIDBU+U+MmTOJfmS+5sFmtuqxddET5FyIyG1OcjAkf4ffdU3DAhnukBRKTcb7QCWMt3t7xZNqGIGD3vjDHq8zzPhblCsFYgTGhQUnSHU/QpEOBju9x73p9MaJR4I2f2QqTm7V5gkMi1Zk7Jgdsbdjlmbbv9eVGFz/N5etQ8uayXVDeIQZNu+lc8zQt+/9Hk0axnGHxFMi6nCNYvjRCiga0+C6icFhRug+mI+T2GKuAbW6lOCVP1KUPvLZ9GETbCYZ4l/XU7V7Iz1W2wWgrDGqRxWPbGh++WuvlB6TekvqaJR/GjCWimEuzNokddpPCWEqT66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUbgegF6ulDwsamrbhKGyM3IEx1IP/C4bGWlVcYLSt0=;
 b=cY+5vjTZi0hnTWX9gBhbBS7z+/J0a6caubqkhnZPPaNNH8iTggmcfpKOt+4P3VMlG8kgFJBM4D1UkRr9lbTCt/8Vf8VaggdFVbFPisXab0qZszThUQ9wyWoyI10+FQpRqAGoMn/evyEU2iIFI8bO+GfsCN5DdE7llbdvbKwZOUr7OkiNdEqHQtsws4ZQ7yv+oK9nVM92zrZ8Fn19E8SQzYWi02TE6l75ngFPVKLsvPbvt2+DxTg5SwE062K1vFA3bP+7OCIE7CZsA46zeLjqYT80luJoOmEoMuEiyle8AuIu4G9CcjMY2uXoMwPStqKkSfMKEIL77HGGmnojuK5cTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUbgegF6ulDwsamrbhKGyM3IEx1IP/C4bGWlVcYLSt0=;
 b=gzRKZuOYj62R8bob9StP4KNEFxUuoyWA+9hWQmZeT/cK6zypRkeCqxS8/9FHnfucHDcY45mNiNH+VSe1zPJM+PPITHm7j2C4LH8/hDVDur6vV605v7I/vukO9tBV9mZBybYozXXo5lwGp6jqtnF2BLfDIcoG5650YFBXjEs5L8V1lUmd/x76sxQDbjpZiUNf63uNkHcbIrw3VCcWuKnFpwE1REqlE+0XKlPsACEKWQb2xhw9zBRQDFRabjxf/IGZ20DmBQKDJQg2No0wBMKyoKsNIOwar3LQAQ7sNO43snnwplqlJIREp1jHxC7GCeAAOu0l+ydyN4ChLtGL0eiw9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:54:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:54:50 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 23 Jul 2026 15:54:46 +0900
Subject: [PATCH] gpu: nova-core: fix packed registry table size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-nova-registry-size-fix-v1-1-8f471ba00ab4@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQBBE0auQXtsJDgSCVyEucKbAdjGQbiAg4
 e6OunyV1D/IoAKjW3aQYhWTMSZcLxn5ZxcHsIRkcrmr8toVHMe1Y8UgNuvOJm9wLxs3RR36qvS
 hbEDpPCnS/Au3979tebzg52+NzvMDOIV/qXoAAAA=
X-Change-ID: 20260723-nova-registry-size-fix-937df64cd49e
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0331.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c26c942-0dbc-41c1-86c2-08dee8874a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10070799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: ihIwaXEfu+GUCqQYwmNo95enYG0kUVFAgRJLoJZnbWdrCfejZ4RKdcgEtNeDhXFFNGu+gheW2eIQfL7UZeBszKrYvT+jEBz+4s5sLaND8sZRmt6FstsJFVnUQiG3+QjYlDhHTfCUq9ZCxlEUtZAJOsVlp7lgFdQi0euw23aRjzRMbBJSYvI5qkCyEf7sK7UyJfKXaJu0sddBFWDMQ3Fy9oLUf1etMkU8ppQWR4coaO948i801VOr9Rx6hReN4gmHW6diz+6VsVOC4Z47BfICnuXhrInJQfv+GNlW8j+FkKZLXwnp9EPcWDlAkfdMFUHx56nsVbodBssL4K9GBLE5VcGR/17NNkGm3VqCFYI8ysQj0koZf0U6yh8LAihnqiVid9TBdWJaullqkXTN96d//DG0TsLMFwIbUqigaZI8i2XVlwufEvBBE0rNnGw49UuP6cWRPQ1nFABPt65Yu0SEp7KUwsM5G9+JBaztabzb9JbaBbkVPUI60jgmW4XgwtCk7XDhXd73mPl9l/cXl4CyXt0rHSZThdYbRu+8NUizXu2oEiLhrmbtXYn6AMflrGEFds1Yp3QLQDeYRJImpBfE8Nx6o3JTc18qNFWtbpNqClTQgF7XA5Pw0zdJz6/V4OyTLIiqI8qd9+zIW3Io1jVFp8g5WVjEp51y0gYcxOAgYu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10070799003)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTloS3ZWR0l2WXFES0RCQXQ5aVNKTjhLNDJDdjNiVzFKS0g2NGh5VU5YeURy?=
 =?utf-8?B?RnZVWFNVV3JQTTlGNTlFZ1UxOWUvU1E1MUxNcGZ4K1FIQkFHbkpCWHJQcGZU?=
 =?utf-8?B?OHF2MUlvK1N6ekFyZmMxMktWeGhJQUNER1RFRmx5Z25IMk00SDJCQVNZaXRQ?=
 =?utf-8?B?ZDZHQzI1a2tTNnZ1M242RE1HZUg4dEVXS2tWVHVjWTNGcEpmZ2xsNm80MlZ4?=
 =?utf-8?B?Z0svVFFLTTVnUmZZZEM5ZXZuajMxT1JlTUJodk91V2I4WENQOFluTXJnV3lU?=
 =?utf-8?B?cGd4M1ljQlJxL09nYWtwK0Qwa0NpZ29ESytLdW1pakVsbkxDbWVZeDdKN2ta?=
 =?utf-8?B?TlZMWGhYWXlEVFFFVUwzcnl5czdXcGVQRkowdkRyTjN0SXplUUxkUTNFOHFa?=
 =?utf-8?B?ZklPdzBkSHE5QlFuR1RnRGkrRmJsaFNUZ25PM3I5dU1EejlUeTVlZlMrS3VY?=
 =?utf-8?B?QWtSYTd1UGd1Y3BoemFudDVmTDNpakJ0KzZkSlZDQm0yY2xNVVR4RUVjbDJI?=
 =?utf-8?B?SU1vOXJyQm5xVTJwNUswN2htc0pwSWFiZElKbTVUQTJKaUc4Y1FweTRmbXlu?=
 =?utf-8?B?TmNKQksybGxFUGZIV2xXbVpTWmtWQUp0STZTVTFjSldUNkw3bkVzVG1OT0Nu?=
 =?utf-8?B?NTM2alFQWFFBNnFuQkRTcXJ4SGZlVER2VWFsTVhpSzltdVB1Mmd4NG9GNHZ3?=
 =?utf-8?B?Ym15QVlUNkZtRlBQT3RNTWdNWi9xNE5odkdoQVhUWFpCaUZSd1c3S3lkYmht?=
 =?utf-8?B?aWd3WUNrb0VjZ1BYdXpFU1pwZEphY3ZDM0NUYTI5NFVVVlY0cGJQcXJleVRr?=
 =?utf-8?B?ZS8wWHZlYUc5MkVMeHhSRjVncnVacjdVU28vNXNYZGpqOHNuYy9kRENLTytZ?=
 =?utf-8?B?MjBiRWJKRU5vWGZMQnNBMElIV1dXRzd3RWdiNGxSMUdyVFhyNkJ0Z0NwOFFh?=
 =?utf-8?B?cXQzcURua0FPMlJSc20rVDVJZ1JhTFV2MjI3TUdEMENOU05EWGhvclFpR2Rn?=
 =?utf-8?B?ZnIxcXV3ZDkyaHh0ejF5U1NUUCt1amJ6U0llY0c4RUJQeUlMOTNEb2Y0V3Zk?=
 =?utf-8?B?QnVNcDFaMlFkaDhxVXA3TEF2ZlU1Y0hka2o1YzNnOUJuaVIvT2M1THpnRUY3?=
 =?utf-8?B?ZGthYzFnY2N0S3JBMVNrSGlOME9JNTFDTFd0bVJIaG5yYXltYkgrKzVWNHpF?=
 =?utf-8?B?V1RDVEVYQUprK2FhUmxTaHdRQmRjZEM1MFZGYkwvYWQrVGd4UEgvT1g5VktD?=
 =?utf-8?B?RG5pSkdNcnlaODUrSGdwRTdmdXF4OUdoVmppZUExTnlYbmlXVGhpbElxL3N4?=
 =?utf-8?B?dmJVT1VCQi9UcXJSam8rRno4bVBWUWpKOTZpZWN0YWNsTFhhNXNWbllSc2x3?=
 =?utf-8?B?TlJtaW1MUkJ0dEVtS1lmZmlWdDNWdVRvb2t3OUpUV1JhL1Q3cmFMdWR1YTZ5?=
 =?utf-8?B?OU5KQjFNak5pM3lHYWY0V1dFbHAvMlZ0cEZXNzJuTG9KZWpIM2xYTE9wK3pr?=
 =?utf-8?B?OXVTa05Ma0kxc3hESmxqR0pnZzBMVWJqWEtpbWcrbzJzdXl0SnBiUmsvUDZH?=
 =?utf-8?B?M3M0aEZkWmNGRFZhL3VNQk1RdHZ1d0FJeWdubEdyM21kNzMrMUlsVFpFeTJU?=
 =?utf-8?B?K2pCUENLNEJNQkI4NU1ka2ljdmEyVmlNdUUvNjJDL2RHRFlnd25GeTRJWmV0?=
 =?utf-8?B?bkpyUUVXSHdXTHVXcFdGTlNMZ3dMdlVFQ1NYbCsra3AyQ0ErZWFwU3luVk8y?=
 =?utf-8?B?d0xaTzN5c1htbXFRQ3I3RE5FY3g5biszaGIwejZkOFBRYVNaNXFlYmVBSjBH?=
 =?utf-8?B?dFExMXpxekFjaFhGT3FuUjJxUVhXVUEzZjRDdFRKQmh0TjEySFlWWk9RZmZ2?=
 =?utf-8?B?OEp3YjdFRnM5eEwrRWp3WTZnV25vTkQyMEJyYzZTUUJSNjBtbmt3TUNLSWRr?=
 =?utf-8?B?RlhoSE5JRGJKTzVYdjFBYkxXbVFTNHRUS2tTUnJ6YnJvYTg4Y0RtREJZRTd2?=
 =?utf-8?B?SzhuYnhWbytCbTkrL3kyemdkOFdiSnRHbEhMSlVIRlNKNy83MEdybjB3R2U2?=
 =?utf-8?B?aXFPWmd3ZE5ZMG1zVm12c3JZUGZ4MTVJSjJFSWlUYnBsQXNZY1prWjlDNWpU?=
 =?utf-8?B?NEthSW00WksrTzBlOWhScXErZG5TY1c1RWxzVWIwMmpDYzd1NkRETVlGUDFC?=
 =?utf-8?B?dElUQ0FtQTRXRG1ZeUFmcEFub1N0MWJZV0kxNDhzUlliQk5uTldjWGRZTWhT?=
 =?utf-8?B?YW4vSkNQc2VOUitmUzgvTlltM3RKcXlJMWFYRGVqWkNaQk9jRzFSTE56MG9p?=
 =?utf-8?B?TUtsLzRybWp2UzRlcWNSZnBKbURNcWU3dmdybzlzN2RKUHQ2Ni8wcTU1VzRL?=
 =?utf-8?Q?oJAbCdn51RIOyToSau291S2PRId8VkusX8kCddsSLvp9m?=
X-MS-Exchange-AntiSpam-MessageData-1: DmWrqD7AO087LA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c26c942-0dbc-41c1-86c2-08dee8874a63
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:54:50.2531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjS8vcTlVw0crfvE51g62X460rMUR1IDPnkJa2+uqzsHd5RaUBWoyxhFB77yzNcEmQ8B392SzqXjmyXF4Zk2pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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

`PACKED_REGISTRY_TABLE::size` describes the entire table, including its
fixed-size header. `SetRegistry` currently initializes it with only the
variable payload length, omitting the 8 bytes header.

Fix this by using `CommandToGsp::size` to obtain the actual command
size, including its header.

Fixes: 19b0a6e7c2be ("gpu: nova-core: gsp: Add SetRegistry command")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260722075253.B6DDB1F00A3D@smtp.kernel.org
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 08380de39048..0f8bd77acddf 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -115,10 +115,7 @@ impl CommandToGsp for SetRegistry {
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        Self::Command::init(
-            self.entries.len() as u32,
-            self.variable_payload_len() as u32,
-        )
+        Self::Command::init(self.entries.len() as u32, self.size() as u32)
     }
 
     fn variable_payload_len(&self) -> usize {

---
base-commit: 5557c238eb0f97169edda1d0776207e3d61f4f16
change-id: 20260723-nova-registry-size-fix-937df64cd49e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

