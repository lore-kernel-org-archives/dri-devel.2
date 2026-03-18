Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E262FFCD0C6
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F5210E6C9;
	Wed, 18 Mar 2026 07:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="spSOM4rS";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4797710E6C2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsRoEw4tzZ4R/5zNfFZdD7EIJuBFxtcCw9miqoBtOiEkxFZMdexGc/q8drWUPCVtTg0FknKMuDquNi81fYflEJVwKHNaU2Y8YbxGNF5tfclIT7XaRbun9G2+dlpMNfwW1e4zIjtfWf5JVLl5noS6w7a0Kbs8hzfLhsyobJclb5lHLKBdvyiBclf6+pnL9lC5g81mTCLHjSCvQczDkJ7aj22NHiUSgMzB+2DPxLyqpt9EJtOf+YCFhd4eX/mKg+ZCojQKczWR3ISO246VmdYt0LAK7WXOx/oDSh0AK3n9bFgqxooFBrO7ZQ4ylRZk4uNctZpVWbdz9f8o1W/frXitbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YMwBR3jVDMnhPMvVdjW3KQZd9/0mxT2MfNEU+qh7K0=;
 b=OH3j77NVS2Ac4JF4DJ3yjvTSuFnotDQBLVltXNEk4g87tL5cAQH31EOvU48TrdtbhjdYj/vNkjRTTUXgd9FwNxVEDviYc4StDzzu/L7NDuUathGfwtOINTAtJC410UxlXrKtgPkZ/Qz1UBaJAY8js8Z2TDEPCpJG0uqh+TLvhqQcuhB+gg730212WEurlN7No6Zx5dxNn1YsMBSScdJ/td9V05rnTXQ+43O4uoQEQy5O3WtbvGkuiOe2bkySoWqZzr2CwcEJR7abGMgo5sgkXp3uGIywPxj2+fe2Tu9KH+NxVZZftuymzVe4zPEY6I3lLGuIcPEQlOHlPgoFfV3dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YMwBR3jVDMnhPMvVdjW3KQZd9/0mxT2MfNEU+qh7K0=;
 b=spSOM4rSLkma1+hPJaqpXBvJNv30/PFmqIOr5wxOZon05+BjcQ5Tc96roBIPKk8oXmVEHY80ktKghJQJ4D3f69yPqnnOS4sWlfo6WE0ta+veWvRPrpJ1AGQFKRBbZ8QwYUunYHz3fhnlL2E0P7m0T1iPaQVCbjB2U/g0hCTpzdfKIhOu1GpxDYM2BKl/jZs9tr7xn1EzsJp1pfkP3e6Xdr5PzwdgcUjhkB2z3+Lb82Kos8KgCkNOS3RF/Ak1Y7fnMUElkqso7Xmk7FO3MKz0Ie/RtJsd1P1K793PlX2o0fgY44F6WkdwYS/DDCRleHMeI4oxQJDhtcT15J8nq7Y/tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:15:06 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:15:06 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:14:04 +0900
Subject: [PATCH v2 8/9] gpu: nova-core: gsp: add CE fault method buffer
 size bindings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-8-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf9296f-a3d4-4195-1461-08de84be14dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: qMUhHw3Vg51yn7aXlhjS0PIpCAcBUH+pvWpmSiJ/UmcbhlI72+KXSE/dQcsejfX5VDtu3tOw/cPKxDTOqcSggDdFn3uD17Z18MTIMtcQqJEu5IkOh6rvL6TJcLzbqMTDhUPGs6L9+9rmX0idO1PXnCiNsl23mx0UAb/Cgug2aLes7eQvZ70udXpZf7DePWKalKySXyy22iHfqKcnpPVqS/N6llNQDyxpCtQUaWvnHgkMYZkky5E01hRnJ4ar1vaoOTcoES+w1sIYK7LqxyMY22qxO1FzgczpYgmtF1nTpPl4sd0DQuMhvvbXm+tba+0Q8TFyA+gXQ2+Gbxwq2mZWHXNRQsa5ttSFb8LKMRhUCEkLxH5kQcJLtEl5gDEv4JsdK2Q3A+miwHxV29QdiFKsfbfYbI9jTF1dCaRCcGCOJdeZIkmsEkp+s07EqJt5T4KPPZd8J0X9RCCEJcJxLJGmXiLsnHGj10UYurmvwQPbimLbUhNm+mO4qC3XGWg8Np7eoy3ij65P3JacEdxsE2YvqBwNsJO+Cxi3ut1UAbKh9BIabtG6DbNH5KmBbvKXuy33s2QaDUKemGGRb+rc5nJXOiCFiuwais/tfMAd1xyKe0gxGuuVBqig7mFuEqvheEddHl81FqWaj6jLl1qcACoBJKuQ67A/LvdaF4I4VzTi/lIpET7NflzUzYghNzqkEcqP6pSSBx1LgA4rzSr1kPt/uf8gEErsXGQzGRv6dLlgJNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTQ1L0Y4VHZyYlpQazk2bWpsUlg1M2c3ZmpuUTVYVnJlT0pUei92ckxneTFJ?=
 =?utf-8?B?QlRGTHRwb1h0YTlmeE1uNWFpYjY3UVBmZUY4WkFrU3BUQlEwbTl6dThvNWlH?=
 =?utf-8?B?ZHVBanBJa0s1M0szN2FWQk5MRE9pS2FDUWUrSERsbmN2emV1THF2a2Y3b0VE?=
 =?utf-8?B?TE01SnBrV3N4V3BKbG5DV1dHTnhGSCs4T3gyY0hBREppdjhLU1ljMzVRdlpC?=
 =?utf-8?B?eVY2NkRKcnFNNGNZWFY0aGxxR3B4RDZFdGhGLzJ5S0ROVDV4TGl6QVRtd0pj?=
 =?utf-8?B?WlpOelpRRUpPWHFhWVU4Wlp5MHpnOGM3cHVWWWF3alBXb3ZmNFprdDRXTWxa?=
 =?utf-8?B?TDN5RXpiOFUydHBUYUd5d1ZZMVAwSzhNcjVlOGRyVVFiWEZkclZNbEpYbytu?=
 =?utf-8?B?Vk1OM2dlRXRwQnJnUlZPb0dubVZ1Yy9NbWM4eFJaU3BsV254NG5SSG94cVRZ?=
 =?utf-8?B?VmZuZ3AwM1pmSTliNkJud3drYWxCbW0yUWJ4SC9CMDNBS0V0QU13Y1ZVdlFy?=
 =?utf-8?B?VGVvQW0rcEtTdURiZDVoV0ZDZU40a3N5YldxMm9aeEJ0N01xelZROXExaDdS?=
 =?utf-8?B?RmUvQ0wybHdPVHJiRksxWE5zRDhtdENKcURrR0g3TUZWaXhRUHhzVG1kaVJ1?=
 =?utf-8?B?RFVreS9DM3k1eDcxUEpMVFRpNlowK2xZSEFyaTFBbDlYNVZ2dUZlQldxczdW?=
 =?utf-8?B?Q21yb0l0OThKTm91SlZ0bzlScGdmSlRkaUdhZWhtMng5MSt1TG5Vck8vZXFZ?=
 =?utf-8?B?SWpMc2NYZXdtaGdjQzFZVURDL2RNeDZMT2lkUFhPVEd6cHRWc1pHZHBGUzdV?=
 =?utf-8?B?VHFrWnQwdTBnWCtoRzRvWnV0U1ZKa1FmcTRJL2RCSERqMjBydFBaMHZjQi9t?=
 =?utf-8?B?UkMvSUZSY3ZVSmRmSC9Hc3NWanJpWWh4MHI4UURObmxjNW1oeFFVN3JPSDJt?=
 =?utf-8?B?NWp6WlNsMGRYN1JuL1NhanJLRjZoc21TRUNiaGV5aksxM2JaWDd5TEJWZE5w?=
 =?utf-8?B?a3lDZy9nL0xSUlVra1hPTFdPZ3dvbjdIN0pSaHZxSFRvckNueHJ6c3c5Tkkr?=
 =?utf-8?B?cjhrTDJsbnBDMzU3b2pMSEoxbTFpY2VIRHo5RkZ0NDRhVWJlVFJOby9oeDFZ?=
 =?utf-8?B?anB6NHQxN1RITVVyRVZiVExWMzBUNUYrK0Y4S25rVTVPT3ZhM3pucEtzWTEx?=
 =?utf-8?B?YU5YeGxjNXlUa25XdzFpQzVuVFlKK1FDZ2Z4dTR6Y0xKMktBVEd0bUZ6Nllq?=
 =?utf-8?B?ZldQb1JUamdQYW1yT1lYbE1aT3hUQ1ZwU0dlTWtueGo4R3ZzdTFDY0ZGQzZG?=
 =?utf-8?B?eEh4K05XQmlSTDJ5bjArajRPWFJlbERIMVgrOUFGd0ZhRVdSSnlicGtncWhn?=
 =?utf-8?B?bDZ6U0RSMHg1amVOMDNNd28wcVBIbERZNFJMSjNlaWMzZVBKVVdFYnVGYmR4?=
 =?utf-8?B?OFpPeWlUQmY4TzVlaFg5Q3d4RjFPcXU4L3g0LzZkbE0zMUJsNFRWWXFnTXht?=
 =?utf-8?B?dlYwUms1WCtnNnhLK2VkM1lkRGdsbHI2czhKMTZRSkdEVWg0bXNSUm9Bd1Mr?=
 =?utf-8?B?dkgvaXQwQmVOdEhncnNSN21nVXlRRjM4ZjNva3I5NW9TMUc0OHltakJNdDBR?=
 =?utf-8?B?bndnbkVvUW51dGc2MnpHUVRYZTZJYTB5RDVUeXg3SkNpbzZjTVlEMEdwVi9y?=
 =?utf-8?B?MGl0UXFpanM2ZUFhOWVReVVaVitESmwwMEEyMDJSSHB1S1FCRlFxVFNxeVIy?=
 =?utf-8?B?QjQ4Znl2M0JyZWRXK3FRNGpHZG1XNThvZUw4ZFNGRnFVdlpIeGdYTThZMWRx?=
 =?utf-8?B?VHZxd0RLNXRCWHFXRUhualhWMEhQV3VGNDlTVmNxUGJwZHdGVU1OSWNrN1NM?=
 =?utf-8?B?eGFqRS83d2d2elFVME5CRERFbE1hOFhvNGkyaE1FbHcrdENqdEdwWnVXVVM5?=
 =?utf-8?B?QWFjTUJMdC8xTHJ2clJ3TTNVYi9keEtlMC9yZmdxU0JhdEtJYVIxZmVrSGFr?=
 =?utf-8?B?dW1QTWl6eDhMR285cTN0UnBzOFRWck9sVk5XVlh2YjJrTWNpWkNLSnJpRC92?=
 =?utf-8?B?eE50MC9Nb3c1ZkIra0xaa3M0TnRpaCs3SkM0QnZoRlBxTE1vRGVzRGpocW5n?=
 =?utf-8?B?ZFpTdnBsODNnOTFHWXVjdzd2QmJZelpCd2tad0l5M0RxMDdrM0l6RUJ4TWVV?=
 =?utf-8?B?YXlwQk5abmgwbW0wemFKd2pWM0Y2N2Noc0VxYm9ETDQzZEo5M21DT3FQb01R?=
 =?utf-8?B?bVNsM05UVHFjaEpYNktKT0M1TlVURDA4dTBxWHNwVDNFVjYxN1BzN0Jia3d3?=
 =?utf-8?B?STdaNHdIM0Vidk4yYzA5OTY3NkIvdTRxZStEUEU4RFl1VnZPYTEvT1ZoOGFR?=
 =?utf-8?Q?meTfDHI2U40BJ+ZdFsH4ltbIWpaEtG8gOz0K127dC0N6B?=
X-MS-Exchange-AntiSpam-MessageData-1: BN2tMj64vJVCaA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf9296f-a3d4-4195-1461-08de84be14dd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:15:06.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDMlJeJioNk+/DPrOPNpvyEVPoPK6LeZmlUj77s8JeqKBCCxzaoktJyuYxmaARGMmJx1KB31/cx0bhateAFLTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

Add the bindings for CE fault method buffer size RM control RPC. This
will be needed for channel allocation and is also a simple way to
demonstrate the usage of the `send_rm_control` infrastructure for now.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index ece31cc32f5b..354ee2cfa295 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -1025,6 +1025,11 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct NV2080_CTRL_CE_GET_FAULT_METHOD_BUFFER_SIZE_PARAMS {
+    pub size: u32_,
+}
+#[repr(C)]
 #[derive(Debug, Default, MaybeZeroable)]
 pub struct rpc_gsp_rm_control_v03_00 {
     pub hClient: u32_,

-- 
2.53.0

