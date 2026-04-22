Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B946F9EDD1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF1110EA24;
	Wed, 22 Apr 2026 13:41:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ey5McSTx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF8510EA0A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNSf5x1AiPc8lp9F7yLY9hr3FsGlD4acimjn3yyVe+W5Mmc/NsbbIJMRyPV5+vGQYoEX8ggkykzRpS4zF38JWgmR4isfRV0P6ZjPsCYv6tfMDtUqjGR57kuuuHkKhWGY9lx6URzzixQASWm/OoY+vpxaJmWNF0Uomr5hIwqZPr4E9j0eAxeH61SJTfuAxRI3BaDC+6sYbNCXodht+KUmZDZOfCloX9GSkzZ3vT8J2+PEAFgBKn/X8PiU9ChdFToS4ZVYt8lQlkyU8lVL+QG6oFXWlvQiBF8rMbn1cvJgMphBMTxO2AE9JOvZp4/Vf1vgLxzwzlA1xawSJeHWsR5uCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/Go4G1wI8uLHvTkQ/rDPtxyqigpHMba3Rc2uycmz0Q=;
 b=x2440xMrPTth+UaEuPR4WpIWP+8FWTirxdMdPw7hkj3P/qegT4pen62+pmvcX2ZaeNhJMK9V0Q5O6NRf3mOj8SyP/3a/HR56gcH/VVHA2585wbNaO1yX/dVrhf5nXn2sGZNQSSQ9ap4LdNNi48Sz5q/rJV7TDXfm5XgLSzt06PhSrOQE3OrCTGr+qos9b13Ra3NSMy+U9zxf4jHq7zoNJ45trM/21kll+VZLEfwC8nA4bNZNqFCZuv1Mf0RpjO3l/zIO1B5BJwZ2GLdGHrUDqbuk/o/ckINBiwvJhGyzP3A8bp754k/5yT2ngkb893PaQ+HxoWCaNmqryyMvGrg1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Go4G1wI8uLHvTkQ/rDPtxyqigpHMba3Rc2uycmz0Q=;
 b=Ey5McSTx8a7MRKijerKpVZ1XDIffBIKBv+EdX9bU+XuvyBHFI+ybWbOwQdJ4jstVgIDORwa92RlHx9dRcaLghcNy2bOV/6a5TL1rCX871gVLp0R+fwjTyyrqGEzKwoGokmL9D0uLpTXPsKknGev3so+2NE5bQVqlad2Bqo5xoBH9oRXaP6H1dQv6xJwtBe8p/0I2Dh5ev/ChUOor2t7O5sqbbgTaLE8JacwAXPqv3Et7/yIW4+8/J4Ld+vhECpd/7B0wiksxeXXoxS8Y4I6orOqZm6Ia+E/acffzLPHuSf1eBEKG+bIzzBLTwGUT8ActMaoTPh4V7HGDgyzHBzdczw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 13:40:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 13:40:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 0/6] gpu: nova-core: run unload sequence upon unbinding
Date: Wed, 22 Apr 2026 22:40:50 +0900
Message-Id: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23M0QrCIBiG4VsZHmfo77TZUfcRHeh07YfS0JJi7
 N5zgw4GHX4fPO9Esk/oMzk2E0m+YMYY6hC7hvSjCVdP0dVNgIHkwBUNsRj6CrdoHG0ZaCvsQWn
 JSBWP5Ad8r7Xzpe4R8zOmzxovfHn/dwqnjCojXQfCeq7dKRR0aPZ9vJMlVOCHFWuBbzFUDIOXr
 VbCDJ3d4Hmev46L8zDkAAAA
X-Change-ID: 20251216-nova-unload-4029b3b76950
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0053.jpnprd01.prod.outlook.com
 (2603:1096:405:372::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 41618051-792e-448a-2a83-08dea074c8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1QG89aLX+huyW8rl5PvwX7lqmR5daMwlxNJxj3KKEg1yW7/i30ykcVFYKCS3e+g2Dq3CWbJIxFTYSZUDwbpOP4ki22atVTIEeRUJqNNBfIns82agUOaouOUT+VNCyuvryiDss1DN6VXh3g3kp0ayTjbylRVc7OAC9ALyiKbrx7WfC7RfQKpeGR1gH8dSZGqvzSYKqm7sGBt9saUvlpfkfzpNk9O7ycrJpjuf6P0l5+/0C3OyVvjnm+cTcWGKsRrsBSvBJochVYChWMZBs5MBhqjOEOzXUZaaRUad9shY4Vw0liI7fpu+dMbK9qlK5AqFPITXHxeeD4PJvEOnHNN25geVsa5GNYqtBVbgIa1nQoPIPl/IrEo0tqC4dlZlBFIUCM6Pm/6XSO9vxA0ciq9bqKAhr8gdYXYOaqTBAsdRM0h2YMaeAp5nIi0e92Ym8z5CodOQzJPyLv+JyaQ2Tl20Q1aVX612UBxFDI8EuuOKQHz4z3NzSwviXexObZ3chcnLz96HqDtRu6HpEptiCM2umbkXGb8Ll1tqmToOaXNTYmI5XNYktKMzu6pKQCw/lCG9K4202SigOrmHqHl704Me+PTbbq/QMuECzYVQM54iJsNu8JO5NczOpxFty4jBvmpbgQn7UhYmNzgXYbXpJxdGJ1vphQ7jKk4JeRo31GDswoNjcIozgCs+inUwByPbBTFyf2XIChqYGNK4BZuj1JrcxnTgIpQPlcCHnB6GZ+muU8Bk4wjbUEGsaSVvGJeUodJn8id8qTGrmnLm3mVSTnpE0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2k4YjZISUkxQmFKNndKSnl5VkNtVDBXZ3hubHBHbXBQRWlkazRmQ1B0MVM2?=
 =?utf-8?B?MTY5aUQ1NnFHVzQyVzY1UTJtNmNFeGlnWmVMdG1ldXNWaDB4VW9ickhlNGxo?=
 =?utf-8?B?SmdsOEg2U2tUWlVkczBDYW1maTF2UE5leEZrU3ArN2g3U0gzVk5iQWkzbDlk?=
 =?utf-8?B?VVdubndWQjRjTU1pT2M5dVZ2ay8rcUxKTUpXUE1FQXJuOU1hcXgxaFZRUjZi?=
 =?utf-8?B?Ym5Ua0NIK3lHOC9jYVhmT1VDQkdvNU85bE9xa2YxUHY1K3NyL3F2RE9mODJH?=
 =?utf-8?B?U01iLytwbHFycllvamhHVUY5TWhSK01QTlhPU09uQ25BS0dtN0hCOVAyY3Fl?=
 =?utf-8?B?SUltejNyWWx1SUVtOFY1SnpJUUlhdE51NEZWT0wyYi90MmNmc0srTVowZ1Q4?=
 =?utf-8?B?ems4WE1iRlRXazNhUDVDMnpNaXZ5QTZBQnB5dHJJa1pMaUl2RXpMUjNWWmlW?=
 =?utf-8?B?dmliL0ZvZGlORjZwNTFtMC9ROGtKQUJnNnVZQW5wRmVwSXlDOUtHakFaNlRn?=
 =?utf-8?B?a2hQdDlKVEdLMjU1Qm5TN2swcHA1UWp1MktxNkRjK1BsY3dUa2FTS2hDRVNp?=
 =?utf-8?B?dXVNRGxHOWxOZGtZK1dIVHhMbTFCYndWcjljeWVGNVA0b2VCM2NwQXdka241?=
 =?utf-8?B?T3B6Ym5RV3JoVWdLbG55dHpGV0FGVE5kb3BONUl4TlpXUUF3T1o5MUtEMDJW?=
 =?utf-8?B?UFdhODMzUEdybVJKK3VKSVI2ck93RnRTUmxIbjM5cGQ3MlNzT1RHdnpONDVM?=
 =?utf-8?B?VndjK3JSTS9yMkNVZzFuSUFVS3NjYk9kSW5oTG5hWlpMS0xwajFaWlk2MkUx?=
 =?utf-8?B?czF1MWprcmtaM0FJSDM2MXQ2R0NGQS9wbXIzRUVuZHMycEV0ZXYrQk9zcE11?=
 =?utf-8?B?K3hBU1NhaXEySnNBdS9ZVlNRYUdKTVhPNkVISWR1aXczNE0wd3NzRVJndUZn?=
 =?utf-8?B?eEFGTFpNSGxXVjVhUkZUR3FYN0pBS0txUlFjdThUNlc2amg4RGI0eFN4ZERY?=
 =?utf-8?B?Y29TeVR4amY2bXcvY1ArcFNoamEyS3NoTVJPZER5dGtDV090Q1hYUlk0ZTdG?=
 =?utf-8?B?dHVlK2Q1R2VjUVZOY0ZrMlFJU1NQNElSenRFZHB6WlRmS1JBeWVoSkcwb2FR?=
 =?utf-8?B?a1VWSFFKaU4zUnpaeUZKZ3BPY0RMZ3hUYlNEOWZUOXkxZzlnNVQvV3FqZ0Rq?=
 =?utf-8?B?VDRXcERpeVM4dUJMYnNmK1UvQTBxS3NVNVMzTURsN1lSU3hmR0UwUktGNGpX?=
 =?utf-8?B?UElFbHArblE2VWhHbjhYdm9EOGxLc1hRcy9JS2s5Nm5PWk43NlVDc1BGN0tM?=
 =?utf-8?B?bTFRUWYrR0pQZkphN1VQQkpyYlByRlNxeUxoU1VXVFZNeitYc2pwZGYvU2l1?=
 =?utf-8?B?aWM4U2NpeXVVZmpzUUpMaTlBT2tiWkZNc0VnYU1adlRGV0tLR3piMTVqOXJy?=
 =?utf-8?B?a1hCRThRYU1teHUwWFF2c3pEUWZraCtDNVBhUmcyNjZreVFLYzhxZzA4SnQ5?=
 =?utf-8?B?bVhMeElUZm5MUzlQdVJRNzR5dGFrNmwzK2ZjYzB6ZXlqQ0t6dWI4RloyZ1Fj?=
 =?utf-8?B?YjdHcHVSQytsZnp3eUpqZGZkTzlWZDJJZGZlSnFKSTRONDB1QTlSbnh4Nmhj?=
 =?utf-8?B?MEdsSzBDNDZBQTlET3hac2xtZ1czY082d3krdUpPcFhHMSsxUkYvTDgxYjVP?=
 =?utf-8?B?dGljalJHbkE0QnBFbzJwckFOYWtpUFA0MHdFVGpvUmVMZTEzZVpudnFZYW9B?=
 =?utf-8?B?SmVpc1dvd3JWWnQxemlBRVgvdnBGV3RUeGZRbHpnY0FNRDErSEVyOHUwNWFW?=
 =?utf-8?B?QzlZNlUrai9MbWdhRWRqc1gvU0l1dzhpdW9kOWJhdUdGZmYrTGdwb1ltT0tr?=
 =?utf-8?B?ZmtDdUN3Mmd3dHZnUTJjbU40SVg5ZUIySWlKc205QXRRUVVYd3V5TjBCSXpT?=
 =?utf-8?B?a3JnMTVHZzczTE8xZGRWTkJZQWdTM1FESnFrMjZCWDhBbDlnWTludVR2WWpj?=
 =?utf-8?B?OXVpUFNmWW1UTjdLM2RqeGdtTkx3L1FEZ2k2eWtqUTZ0S0l0aFdOWmxmUDJY?=
 =?utf-8?B?T0pGUHlwWUVXVDk4YjN0UWtIQmVQbDlTTFVKMVVzWXAzem52ZkFrVGlkWFBi?=
 =?utf-8?B?MlYzZkdMb2xmV2NIdWIxYzdPZkhBK0xxcU9tNXRvWkVLVUthOCt1bkpIV3lq?=
 =?utf-8?B?bkJKTUN6QTZac2JCZHUrcjNjd0ZVOC9CR1pCWk1Zb0kvS3ZtSTR3aDl0MUQ2?=
 =?utf-8?B?WDFkc0dISHo5RUs0WjNiRUtycE01UmxZai9CbVZUNkJnaVZPVDE1UTIxOURl?=
 =?utf-8?B?VXZNVVhZeEUxRWxJY1JXMUtXTHFpTnB3L09BYTBDOG9PN2JBSWkxQkx6TlEw?=
 =?utf-8?Q?pofeAEeRseTrPv+22vaVAS5zHF10BcIgZomtSZj2LSMJb?=
X-MS-Exchange-AntiSpam-MessageData-1: uhwILoO33KoVmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41618051-792e-448a-2a83-08dea074c8fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:40:58.4863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mraDKBj+c9O+keK9KusHbGIwUrTRrcrgxp1n6ALyEymchhP4NQLGn4zlGsT7WAdUKzPIVHUeIGIZl2Vm14d4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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

Currently the GSP is left running and the WPR2 memory region untouched
when the driver is unbound. This is obviously not ideal for at least two
reasons:

- Probing requires setting up the WPR2 region, which cannot be done if
  there is already one in place. Hence the current requirement to reset
  the GPU (using e.g. `echo 1 >/sys/bus/pci/devices/.../reset`) before
  the driver can be probed again after removal.
- The running GSP may still attempt to access shared memory regions
  which the kernel might recycle.

On top of that, there is a nasty bug in the Blackwell VBIOS that
sometimes borks the GPU upon PCI reset, requiring a reboot. So relying
on the PCI reset to unload/reload Nova is really not practical here.

This series does what is needed to leave the GPU in a clean state after
unbind, for all currently supported GPUs. Blackwell support is trivial
and will be added alongside the Blackwell series [1] if this can be
merged first.

The first patch adds a `warn_on_err` utility macro to the kernel crate
as it is useful to warn on failures in the driver unbind path, but I can
remove it if it is not deemed useful.

This series applies cleanly on `master` as of today.

[1] https://lore.kernel.org/all/20260411024953.473149-1-jhubbard@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v3:
- Disambiguate doccomment for `warn_on_err`.
- Test the correct bit instead of the whole register value to determine
  that the GSP has stopped.
- Use an enum instead of a boolean to encode the power level when
  shutting down the GSP.
- Add missing newline to `dev_err`.
- Add missing doccomments for new types.
- Use values from bindings instead of magic numbers.
- Remove the redundant `get_gsp_info` function.
- Better document Booter Unloader mailbox sentinel value, and check the
  value of mbox0 upon return.
- Link to v2: https://patch.msgid.link/20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com

Changes in v2:
- Rebase on top of `master` and remove unneeded/obsolete preparatory patches.
- Tidy up the imports of commands from the `fw` module in the `gsp` module.
- Link to v1: https://patch.msgid.link/20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com

---
Alexandre Courbot (6):
      rust: add warn_on_err macro
      gpu: nova-core: use warn_on_err macro
      gpu: nova-core: remove unneeded get_gsp_info proxy function
      gpu: nova-core: do not import firmware commands into GSP command module
      gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloading
      gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding

 drivers/gpu/nova-core/firmware/booter.rs          |   1 -
 drivers/gpu/nova-core/firmware/fwsec.rs           |   1 -
 drivers/gpu/nova-core/gpu.rs                      |  21 +++--
 drivers/gpu/nova-core/gsp/boot.rs                 | 100 +++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs             |  69 +++++++++++----
 drivers/gpu/nova-core/gsp/fw.rs                   |   4 +
 drivers/gpu/nova-core/gsp/fw/commands.rs          |  44 ++++++++++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  11 +++
 drivers/gpu/nova-core/regs.rs                     |   5 ++
 rust/kernel/bug.rs                                |  10 +++
 10 files changed, 241 insertions(+), 25 deletions(-)
---
base-commit: b4e07588e743c989499ca24d49e752c074924a9a
change-id: 20251216-nova-unload-4029b3b76950

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

