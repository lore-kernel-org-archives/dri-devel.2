Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007D9FF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF4D10E495;
	Sat, 25 Apr 2026 21:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WkGXq07X";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D69510E48C
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXQLZuMi8uMBkRJt34WP8Niwemfmjahu7olglmklEpTzbC43X6egbYC5aQRYZ2PTTDRzKbohmcB2rJF3H/amnE6ZihUqIP38w9weKHAS6BzGhhwt0sI1+wm6dxs66Th++vskRXtntIIsQ0KxVhr+TfsnoNAuh5ktCu7Qq2Ze1Xxb8b2MIPZnmmjDRs+ShEtJjvRxf0/as5ih+u5qz8JHTs51sKvJyDJpDZ82nsPtv0WNG1w+Obk8dtT2fJKTqSnQlsyvod+KiWgsLDpJPgB7W57krPwz/ImH0zPzUgk5rOSXxqxi8TLMQygDv3sKmhTgR1Eay4cO6hJxpEhXl/VPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qmJQf1nOGBzIuT2FeWQpXQiJAcCl+Zo4jxDxKOdiWk=;
 b=IxgLEp21o00yNV5sIE51Z1n25tSlj3r3eY7hnqOzQON0N8dAuo+0F6vTURbdaI/kjm7xLNz4AwKQM1Zv94jHlboKr/r9s7LT1K/NyP8cJWgoZex36PXXDuqIOLpKgyPsLFzb990jfTWj2YDNLHSf2hCZmPC3l6YX/mg6c+apAPu2mGPfVvwFGOJzQ22R57/XPrj/KhzSiEZX6tOpZpFF0A0o2rlHW8hIE1Y1z/KKOKYLe4ltjaLB1E5bxZFHX1j4Q7yDMPH521bKP1fSaiCWF3VuRLQi20nbklC6s82xM/QJ01xwX0/w+vFNoR/sb6QV9f0z8ka3yxBBnz6aOQ5Hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qmJQf1nOGBzIuT2FeWQpXQiJAcCl+Zo4jxDxKOdiWk=;
 b=WkGXq07XJACErFInj/dgQ36HUhvnSlEG7mJ1khJ3DtH9XRmsyofkh+l66H/L87dOkTFKTiVXfc6ncYcdw57600fRocrFpIliJT9dUuICK3XtIJNVMwlf7J0AVuIfvjQTwFuE/I03EWmr0/Qj+IKfcPEitXFwyKdyDd9IMf+O0i0peWZCCL2dIcZgi49/9z+exrYIvcOXmwKV0S8lnCa/vbhqHXi/JR6dMz66AlntNiXgte73f/ivldN9Iuc+DIpot61RZydvTUT5hsvPULusBwVqWFAB4nJ+RkQPz/sodh3wPNZu++Qg9sMgcQzvhmx1zgY16Lok8IkHMT2uVboBYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.13; Sat, 25 Apr 2026 21:15:51 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:51 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v12 20/22] gpu: nova-core: mm: Add PRAMIN aperture self-tests
Date: Sat, 25 Apr 2026 17:14:52 -0400
Message-Id: <20260425211454.174696-21-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:52c::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0a9194-9243-48b2-4794-08dea30fd45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|11006099003;
X-Microsoft-Antispam-Message-Info: KDcM8RcMtmadt7ncIPIETCQslHxyqzn31FnptBCAyp/DvOqHN1fLJbpV5VNjfYKQdhr1SZbC0VLysUdbpq7urlAYYzwXE1fxu8ESVhBjaq//G75bwAhcaF6I5uTx0unGtcHN5+iKMgGHefw04u75dk+tf5f877vblpYr13FNz8T3xxSH3yF/aozcvtrkPNmTESSCtA4BAWeFCuT8ro3qUhlUYoymoXaIx7ipdqoTmwteoHjj8APhE19rlj0nXUnV6OZ675X/LKO0pFd2RfvydZXKe8gGZje8ozjoi7Or7wz2wg/CD5CFaU0MMBko9cdBswgrTOPYNdIbrYngv4q/gOY6pX7pwmoBj+FYd7VBnhlP1flmK07djS8wXyYeMb4uTolTztiD3Nuoi25P6ocqWf+l0SOvKeJ0vEnihy+YmJ13bmQWy+qAXMjTXGLIDHcNpTZSbWag2w6XPsNoYzgoQGrNyw9AACU7FiRdYWQisLJyAT6GSFbv4O2yavA9TOApWe6mWvbH7r+GFiELi/oMeVJKjYFite82UdzWnwBbFfMhqWS87nNctu4v6vEAXfKAAYl1r7h63QFcpWEpIhCWO1pMOq7hVD2CU7Fe1xKluP+uQsmB1gfpmgSe6mIfJZ8NyN+KXN+slLjfYQKljxjyYeoftgMnf7ptoXVgxp+JnOo1VEFtxUqi2SXqb6P87sIf+8mHpGQceVJKnVOzS4eM/gFA8Gn2MVci73YLhySRMDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11006099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?opVW245kht3QDmyUjOxGMcvdYKIWCVZth3nTNEx0T0AlNLaycuRX90yUrzd8?=
 =?us-ascii?Q?XeTbgS/M1qjlARIjtwZo7EfkuB61YToTZkQt2jW+KjVA6AByD/b4+K7bkKEG?=
 =?us-ascii?Q?iDQAZkixRVtrGbnKREwR89dx8jzTHq4PfCpEbVBNubUXrqIouin1jwbfOyy5?=
 =?us-ascii?Q?O4zNkFUddveV84c+9Kl0pnqM2z9xi9RIEdGGrZrQiYq1BSnqn6/dEMYRhIbx?=
 =?us-ascii?Q?+juAB/FY4Uzl/mCM48AWNt0mw0Y5wVy9qUPO5N88MZaTPyIEPhGkGLI7vhLn?=
 =?us-ascii?Q?X4WnWOr84PZewiNrNNgvZBTv1N4zu+tE0VKN1I/eYg6d1zMuSmj6BKELphrg?=
 =?us-ascii?Q?Hu42U43PbdwFfdbI9stfQm85xShGZWUOZjUfhQBQugKeg0xBrnR3r4Ay2DWv?=
 =?us-ascii?Q?+hVnvOeEhxfGFSsnBAAtQjtgX/vhCka9BIx9iWqtJIBglAAqQnRoxrbQTPAB?=
 =?us-ascii?Q?r5tmLV/8exWnj7ItQdzx5LSKUeIjnTvwhUu5E2NEVKrovZGLu5qCXmMLYQ9/?=
 =?us-ascii?Q?AbYFgJBk1b6YX6qNpJ6sPlriBxllotFzE06hb3g6HJvw0OxOwRyBnBnHodyT?=
 =?us-ascii?Q?NSThqy9ooNlNO6d+FC4Egc+JOgIZ9zFs0W2L+OYLDKi5KFbRDOOtDDvgCAr4?=
 =?us-ascii?Q?ZK1gv/JbVx3i9nrqEDfOuP2P+t0llcdfXEonCZxS7akpcVZQTm5RgYrOljDm?=
 =?us-ascii?Q?mT32XgmlF2qKCzMo5qEEquR7BasvgF7E2Ks5IeWWtJaX2w4RGOrDnbWKXnfl?=
 =?us-ascii?Q?VqN/912fNcLIQiG19LODHFohjiDeTzR1edpm3YIiWg1228LehlN9DIbgl8sz?=
 =?us-ascii?Q?5BxV/BJW+ms9RwMcgMjjXHpmQQI4ai+m8dZFI+7ZCfVUsba/tVLWuJHYkWT7?=
 =?us-ascii?Q?cHYZLdXW5Iz6eKZL6oGDoWeavGPQY+eZ+rxbsuzMvqrnHJwsLwISnbo7iSuh?=
 =?us-ascii?Q?2wWxjI3Bxh8+HXPZQEu5z3k/00p2g6LqD2f4k3YRJ2XQrjoa82XfAUiDVw0N?=
 =?us-ascii?Q?udJi8vkkYk+o0usF7xOrBb6wgWOmBcq7IB69FQ22Qly0nBzlWXrWK8+VEG8d?=
 =?us-ascii?Q?BdWCXybiyE8nFN4/OnIXMqZzAPwfkAGQUi94BMAdI2ttUmc13MyFghg7ihJB?=
 =?us-ascii?Q?itg7sShX1Mc4S2UwFIQu4WjfDPC9EJwpjHAImJGIWbiEHaS0jy8jeCYT9El1?=
 =?us-ascii?Q?hTyZeZrHCuFqD802W72gKNIqMU4f28WyeN51V1dE+VBFwkozGzjWv4dXc18e?=
 =?us-ascii?Q?tHBBqvjKyn6a/X0MU29e7ICdxy1SPXQnfFb/aOXpVWMsfWFJWf+yqZ0Hg8nS?=
 =?us-ascii?Q?26r746+/xcxAOa8KU0Z0roOiOJ/NUtJ4/kgK5bg18oROhsnA/CUbS0w6ZJf7?=
 =?us-ascii?Q?LvbUrZj91wyIqVIzysYUJ62uj3k0+rS/eKpnNct1/36fllIDwf6P2G7YrpZK?=
 =?us-ascii?Q?KnswSv3r7nynLaqfNbZQsvDOnA9NeeQDmcAdzmVHA8i8PnIDCfya1RrChXt3?=
 =?us-ascii?Q?FbucbTR2a/ZbJ8tejFFP8rFgmhecJb148vD4pUpm2O4Y7IDcOymQ+L5CKkYq?=
 =?us-ascii?Q?Zi7nHHFW13sxT/OKraam3nwFzpi95jZdAijmXzeA2MozRUXU5dXCyvRvkuV8?=
 =?us-ascii?Q?JrZT7u5zx3C9/a3bV0BzgFC8VXqM0u7iSkH6GaEVRUxDNJAZQJZJABiNyspz?=
 =?us-ascii?Q?ryCoWupyj1NMxLF0Jtr0X3RZ3QrfCWKK7DkbNGaw6vbNQ1snuoukt6EyXMTo?=
 =?us-ascii?Q?UTUllaRRug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0a9194-9243-48b2-4794-08dea30fd45a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:51.7195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrbEdyFCyFrLmtdv9kHbi8VsSy2Xcf5nvd3tRKU4WjcbtYMYTZ06PlAtNfTopRo8KP30aLvjCfOHCh10sgyHzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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

Add self-tests for the PRAMIN aperture mechanism to verify correct
operation during GPU probe. The tests validate various alignment
requirements and corner cases.

The tests are default disabled and behind CONFIG_NOVA_MM_SELFTESTS.
When enabled, tests run after GSP boot during probe.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs       |   3 +
 drivers/gpu/nova-core/mm/pramin.rs | 211 +++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index e94f5374eb67..b3c33bebd8d6 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -358,6 +358,9 @@ pub(crate) fn run_selftests(
 
     #[cfg(CONFIG_NOVA_MM_SELFTESTS)]
     fn run_mm_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bound>) -> Result {
+        // PRAMIN aperture self-tests.
+        crate::mm::pramin::run_self_test(pdev.as_ref(), self.mm.pramin(), self.spec.chipset)?;
+
         // BAR1 self-tests.
         let bar1 = Arc::pin_init(pdev.iomap_region(1, c"nova-core/bar1"), GFP_KERNEL)?;
         let bar1_access = bar1.access(pdev.as_ref())?;
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index cc393f1509d7..6a62cb5aaf53 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -201,6 +201,11 @@ pub(crate) fn new(
         }))
     }
 
+    /// Returns the valid VRAM region for this PRAMIN instance.
+    fn vram_region(&self) -> &Range<u64> {
+        &self.vram_region
+    }
+
     /// Acquire exclusive PRAMIN access.
     ///
     /// Returns a [`PraminWindow`] guard that provides VRAM read/write accessors.
@@ -302,3 +307,209 @@ fn compute_window(
     define_pramin_write!(try_write32, u32);
     define_pramin_write!(try_write64, u64);
 }
+
+/// Offset within the VRAM region to use as the self-test area.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+const SELFTEST_REGION_OFFSET: usize = 0x1000;
+
+/// Test read/write at byte-aligned locations.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+fn test_byte_readwrite(
+    dev: &kernel::device::Device,
+    win: &mut PraminWindow<'_>,
+    base: usize,
+) -> Result {
+    for i in 0u8..4 {
+        let offset = base + 1 + usize::from(i);
+        let val = 0xA0 + i;
+        win.try_write8(offset, val)?;
+        let read_val = win.try_read8(offset)?;
+        if read_val != val {
+            dev_err!(
+                dev,
+                "PRAMIN: FAIL - offset {:#x}: wrote {:#x}, read {:#x}\n",
+                offset,
+                val,
+                read_val
+            );
+            return Err(EIO);
+        }
+    }
+    Ok(())
+}
+
+/// Test writing a `u32` and reading back as individual `u8`s.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+fn test_u32_as_bytes(
+    dev: &kernel::device::Device,
+    win: &mut PraminWindow<'_>,
+    base: usize,
+) -> Result {
+    let offset = base + 0x10;
+    let val: u32 = 0xDEADBEEF;
+    win.try_write32(offset, val)?;
+
+    // Read back as individual bytes (little-endian: EF BE AD DE).
+    let expected_bytes: [u8; 4] = [0xEF, 0xBE, 0xAD, 0xDE];
+    for (i, &expected) in expected_bytes.iter().enumerate() {
+        let read_val = win.try_read8(offset + i)?;
+        if read_val != expected {
+            dev_err!(
+                dev,
+                "PRAMIN: FAIL - offset {:#x}: expected {:#x}, read {:#x}\n",
+                offset + i,
+                expected,
+                read_val
+            );
+            return Err(EIO);
+        }
+    }
+    Ok(())
+}
+
+/// Test window repositioning across 1MB boundaries.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+fn test_window_reposition(
+    dev: &kernel::device::Device,
+    win: &mut PraminWindow<'_>,
+    base: usize,
+) -> Result {
+    let offset_a: usize = base;
+    let offset_b: usize = base + 0x200000; // base + 2MB (different 1MB region).
+    let val_a: u32 = 0x11111111;
+    let val_b: u32 = 0x22222222;
+
+    win.try_write32(offset_a, val_a)?;
+    win.try_write32(offset_b, val_b)?;
+
+    let read_b = win.try_read32(offset_b)?;
+    if read_b != val_b {
+        dev_err!(
+            dev,
+            "PRAMIN: FAIL - offset {:#x}: expected {:#x}, read {:#x}\n",
+            offset_b,
+            val_b,
+            read_b
+        );
+        return Err(EIO);
+    }
+
+    let read_a = win.try_read32(offset_a)?;
+    if read_a != val_a {
+        dev_err!(
+            dev,
+            "PRAMIN: FAIL - offset {:#x}: expected {:#x}, read {:#x}\n",
+            offset_a,
+            val_a,
+            read_a
+        );
+        return Err(EIO);
+    }
+    Ok(())
+}
+
+/// Test that offsets outside the VRAM region are rejected.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+fn test_invalid_offset(
+    dev: &kernel::device::Device,
+    win: &mut PraminWindow<'_>,
+    vram_end: u64,
+) -> Result {
+    let invalid_offset: usize = vram_end.into_safe_cast();
+    let result = win.try_read32(invalid_offset);
+    if result.is_ok() {
+        dev_err!(
+            dev,
+            "PRAMIN: FAIL - read at invalid offset {:#x} should have failed\n",
+            invalid_offset
+        );
+        return Err(EIO);
+    }
+    Ok(())
+}
+
+/// Test that misaligned multi-byte accesses are rejected.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+fn test_misaligned_access(
+    dev: &kernel::device::Device,
+    win: &mut PraminWindow<'_>,
+    base: usize,
+) -> Result {
+    // `u16` at odd offset (not 2-byte aligned).
+    let offset_u16 = base + 0x21;
+    if win.try_write16(offset_u16, 0xABCD).is_ok() {
+        dev_err!(
+            dev,
+            "PRAMIN: FAIL - misaligned u16 write at {:#x} should have failed\n",
+            offset_u16
+        );
+        return Err(EIO);
+    }
+
+    // `u32` at 2-byte-aligned (not 4-byte-aligned) offset.
+    let offset_u32 = base + 0x32;
+    if win.try_write32(offset_u32, 0x12345678).is_ok() {
+        dev_err!(
+            dev,
+            "PRAMIN: FAIL - misaligned u32 write at {:#x} should have failed\n",
+            offset_u32
+        );
+        return Err(EIO);
+    }
+
+    // `u64` read at 4-byte-aligned (not 8-byte-aligned) offset.
+    let offset_u64 = base + 0x44;
+    if win.try_read64(offset_u64).is_ok() {
+        dev_err!(
+            dev,
+            "PRAMIN: FAIL - misaligned u64 read at {:#x} should have failed\n",
+            offset_u64
+        );
+        return Err(EIO);
+    }
+    Ok(())
+}
+
+/// Run PRAMIN self-tests during boot if self-tests are enabled.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+pub(crate) fn run_self_test(
+    pdev: &device::Device<device::Bound>,
+    pramin: &Pramin,
+    chipset: crate::gpu::Chipset,
+) -> Result {
+    use crate::gpu::Architecture;
+
+    let dev = pdev.as_ref();
+
+    // PRAMIN uses NV_PBUS_BAR0_WINDOW which is only available on pre-Hopper GPUs.
+    // Hopper+ uses NV_XAL_EP_BAR0_WINDOW instead, requiring a separate HAL that
+    // has not been implemented yet.
+    if !matches!(
+        chipset.arch(),
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada
+    ) {
+        dev_info!(
+            dev,
+            "PRAMIN: Skipping self-tests for {:?} (only pre-Hopper supported)\n",
+            chipset
+        );
+        return Ok(());
+    }
+
+    dev_info!(dev, "PRAMIN: Starting self-test...\n");
+
+    let vram_region = pramin.vram_region();
+    let base: usize = vram_region.start.into_safe_cast();
+    let base = base + SELFTEST_REGION_OFFSET;
+    let vram_end = vram_region.end;
+    let mut win = pramin.get_window(pdev)?;
+
+    test_byte_readwrite(dev, &mut win, base)?;
+    test_u32_as_bytes(dev, &mut win, base)?;
+    test_window_reposition(dev, &mut win, base)?;
+    test_invalid_offset(dev, &mut win, vram_end)?;
+    test_misaligned_access(dev, &mut win, base)?;
+
+    dev_info!(dev, "PRAMIN: All self-tests PASSED\n");
+    Ok(())
+}
-- 
2.34.1

