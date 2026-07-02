Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F44FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F278210E468;
	Thu,  2 Jul 2026 07:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WfA8+34E";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3438210E468
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwenA02/9W3FTqgEDrO5TE1glD4+n/72WuTWjejBMkAtGdz9h6xDj5HVipXg6Xtx+AyE43JYPcN8tl/VbAiqG9BiIBZf4MtK+Sgm57IkOX7YUtuKIaY3wlaj+TiRFsKTD37KB1Gs0wdKwFAPLfyiUdO59+mbvJ3kTmqo59OA1MT3ZueEruis7GpeNTVh2HyIDrlWmkhw+KqdHI/N5yuVG9insTwMcoIJSDO0BWXKUTrMhQJ57tsLDM0uP72u0BIZURHNhgs4i4shIUa2jkW0+xJR/0o2AslU4LWIvT9wcItjwEzg3nvGIQDDYYbZGBGALVX8JjOxYn5I4G115Y1m+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN2jPfOB0Z5HEOumXZ7b9IreyM5lXs/N63P+BA0bQEE=;
 b=AG4vyGcbcXeGYPZAZPsTo94C4GYSvxQ30Lv/fFx+ZkrSrSebiUIYcGFStK1Y5lfz0RTtTAuDNopSDIeh2W7Lf0uLNNzEskYqHmN3zWKp6eGjbt1JZTNujuEXHtzASIGNKUv4GINbgsssRJLdKR64YmvfS3Ms0y8Dpyskj1ED5ahSCzQfoKvL+OlB851orj6NgLr9tLvaDpAPzCwExy8lw0TjeMsPMggOJk+vU2/cl77Lje7jWdviA8rtYjYtd1gg/Z7fZDbAunxlwKUwhejf6A2nBB1lfQcObacq/I3mciNBSAoPPpKli2LKa8M87BKs3B3MgrHsNlWKSqqphlGXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN2jPfOB0Z5HEOumXZ7b9IreyM5lXs/N63P+BA0bQEE=;
 b=WfA8+34ELEJBPJNHmcwd7K+kt8nnr/Q8RTf5cyq7mUiYKRyC9nFS7lOnfpD71Mh1pVfNCRLaDUPHBQQIxn1Ie49PTB8aYDapRBCcTHSzjvKXt4li7q9zNBeojkCq4P3kU/pD7CrCmlqzZ0Jxz9MZQWozv4A1r+uDZmjpGUKrh4Qa+CIaYXmAydAYQbAWgGLF3o8LMiV3GsAWV1eaALJk6p1npAE+tURO2GXlU16uOM2PaB2rDWTl5++mIroQAJgV6/qfvq7mb9HKmWmMVsfe/9VfcqB8q+dR7lCCRSq5L5OvKACLl2vfiThLR8obNiM83VLTaKb8TitqRn9CHBWjcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 07:22:26 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:22:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 16:22:22 +0900
Message-Id: <DJNWKRX8SH2B.2TT8O2NP3NVDM@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 18/19] rust: drm: Pass registration data to ioctl
 handlers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-19-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-19-dakr@kernel.org>
X-ClientProxiedBy: TY4P301CA0114.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 755d004e-10a7-4a7b-288b-08ded80aab10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|22082099003|11063799006|4143699003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: vs5UGkVkmN6VuWLdCBo4uQ6fgvmvq2kk0ri8bNgd7Uza+4kSP2cyi4nP2m+IA/1JrrABAt3VtH/WlOins2DSUnekIH1hJjZzqc+j1M8fzRHLVB/1mOd3ak7ukqQhff6CXZHuI0s61xEuYn+XeAwadefITrBEmvI4tPxN2dXvxEsEC770LkNygvOQvotMzip4VbI9n/UE9piYFFPE3wRNekgib3XeF5DzaZO/qz5IAgw3vMlsEgTFuTvxTbh3YUR1e2RDbZg+yXu4aPXYphDgX/aTlAFdbW51ZAPY4yo+/g07hhazv4Djy8b19taXf0yfufMWZW7KQ7OUvIseYigZu85AsEUcEhkPJDmYhZwLD0tGR/bTj8a/igP5JNpq/dyWYUlfBD22Sq4gQPflXo1nY4XsruHWR/FGvwIzvQCVvbGzsJHPrakpxOgvDFxIubC8qexILSNwuAbw4wK3TB/Hm0nuZpCkkEy01nFIRHbq1CEjFwe/cFZBccYGk1fpylRncCm+U6SghUnPk+WmXB65pNArPGQPg2ekNHaNcGoDzBeLsplFmDhjvPL42jHECjQRIR5XG9hk07LkPbfidfE+6rYhvPdKZLwOfavuJoEE/AvcSSVrjsAkFNiqz1nsuoA+6HHHHvVss5ylQ7/Iz7CsCST6TD9cGPCkt8sRPoSDWkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(11063799006)(4143699003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azIzT0VQRGZja3F6RTQ1ckxna2t2b1lXRUZrc2RjaXlyL3BrRUs4QWV6Tkhh?=
 =?utf-8?B?dmMrSmNVU0NWNGU3dWNCU096NVIydEpjdEdsMWlKNXhWOVc2UitIYWZYVXlH?=
 =?utf-8?B?QUxlaFhveVJ6RWVqUzU0NU1vNmFXbVJ0Uy84bW11WG9EeHdkRzlOYzQ0eVNB?=
 =?utf-8?B?enpXRkF5NzBaQUxtTDFhZU5CRkwyV3RhRHlPRlFoYmFmNWVxMDBBcktnNEpo?=
 =?utf-8?B?VFNtNE9aVjVsa0JoQzZZSlpLVCsyNEZhV0lIZTJSUkllczJUbEtCUDlySk1n?=
 =?utf-8?B?SnRES1B1Rzl2dXQ1QysxY09pZkVtNGtVeFZzZUlxemQ1WU5hWGhFclFKbjFK?=
 =?utf-8?B?ZVF5Z3lTMHJCVElOR1JLWVJPRnFDU2F3UnltSURhUTIxNEs4WXM0dlJYcDBX?=
 =?utf-8?B?RUsrQUxZNDY2OVdDVnM2M3E4amNYaTdsQVJuOVVmMFZmM2xlRzlrK2xaanEw?=
 =?utf-8?B?YkJ4anRYaDFDTVlwYWVDQ3A4NjJ4alJjZVJ4L2pQQ1BmaytVdjV6MnV5WDlP?=
 =?utf-8?B?NEh3WkJhMC83MGtRRlI2c0N1aVZOUktnM3hZVGpWa3VHUFcxUXBNbi90eUZR?=
 =?utf-8?B?R01HVHdNUkRKV2ViU3RBMHFDRk1FMVpjekNhdkx1YjNIRGpKaytWUmU1aWd6?=
 =?utf-8?B?SGowTE1XUGVWTmRXQmhRMExWWDl5Z0ErUzFOS1lSczZPcmpEVENLejZhOHVW?=
 =?utf-8?B?OGJSN3hUeWJzZFcra2ZkR1dIM3cwS0l3dUlGQ1ltODJmbDdUUGYxUVNjVnkv?=
 =?utf-8?B?VHZwRjZIWEhMSXkwcHpOK0dselpqNjBlcCtkbm9XUWRhYnhnZE5XOE9HT0Zt?=
 =?utf-8?B?VUlicnltaS81eXQxNEJVN3Q0ZWNxamJpTE5TaDVieERHaDRJM2NnbFUzb1Ix?=
 =?utf-8?B?YTlWTmZVVkhQa0QzQjJlODNHWXBrL2FsYlpSU0FlR3YyUDRaRW1RbERvTWdI?=
 =?utf-8?B?cGgzZXVGVVVoU01lRktYaUNsVTJLK0d6Z1pBanVVaFV3RzNmVWtIbHFqcEZD?=
 =?utf-8?B?THl2YTJNQ1N5a1I5M3JUNWNCZmc3TkdwbWI2Yjc0TnhJTlhyV29Ic0lyajdq?=
 =?utf-8?B?Vml5L2xXNmtLY1V1OGU3dE1ZYWlDL3RjNjk3S0ZrZ1hUaHRZdTkyWTYrMzVG?=
 =?utf-8?B?dVJzSjllejl0TEdhNk9Mc2tZNStvNnR5eWI1NDV1K0VFMVNTaFpxRWVLOG5W?=
 =?utf-8?B?TS9wNzVRalI0S0lOYlpUeGVHVkVUbGc2djJqeW9ESzFJQVpCMEwydXlhcFQz?=
 =?utf-8?B?Y2N1V2VlT1dLdEt6RkFWalNOaFNvbjlvTURNQ2pObzNzZWRocWlMVlNXaVY1?=
 =?utf-8?B?YlRDRVZJb2FjdFlBMmVLZVRabDJweFFnclJ5ZkgxTUhXMVFwbmNoNE5sVTF3?=
 =?utf-8?B?T051ZTJhNzE3MmMrajd6bU5OODNSYTlOUDdXZElPbXlpK2FlSUF2dmE1TGxs?=
 =?utf-8?B?c0NwR0dDSE9CK3ZvNFVnSHJGVTNoUEhsTTFxdHltNU5ZUWVobGlzZ3R0d1Nm?=
 =?utf-8?B?RHcyY0pNYk5nRkYzUXFzRmczaDVKTGJQcURJMHgxT1lhUU9oTitBZHVibGlO?=
 =?utf-8?B?SlovcytkVjE4RkxaY0F1YTk4VjY4MUZTRG0wdWtjTlZJazBEYjViQ2J2aHpK?=
 =?utf-8?B?bWx2QTBWQ1A1WnpXQWFWakMwb0ZrenhWbGRjeDl6czgzR0FXR1pCL1YwMHdV?=
 =?utf-8?B?UUhGRGE4d21IRzBaR2padStBS1lmbmVqb2lNTDgwSnhOR2JpeEFGUGRRb2dM?=
 =?utf-8?B?OU5wRTRWZEdOSmhqaWJVMldRbjM2SE4rY05CaWE1N1hRMWxjSXg5T1g0bllt?=
 =?utf-8?B?SGVRRm9XK29vS1dnbWp6RG00V1dMUHNqa01Zem10eWxTM1R5VWZoUjhQRVBN?=
 =?utf-8?B?SkZ2enlWTU1qUVRjSndxcEIwRkN2YTJvNHJWMitjMkR5cCtIcGxHb053U0g4?=
 =?utf-8?B?YmlsQU8vMU9CeXJNdEFjOFdraXlMaHd5ODZncDJINUlscHQrQm5ZRWVmcGJF?=
 =?utf-8?B?QWlvTlV0SEZ6TXMvQUswL2tUK1RqVVRMOXFuNXdsalpobHR1UE9UT2szKzJM?=
 =?utf-8?B?SzdhT3kxZStBUmJEZEJqZ0VBMnlYWStORWNMbnBuRmlsMnZhSUZBR21kSmEr?=
 =?utf-8?B?WW1UcmlpbEF2WUhIQWphWTFQS3lHVHNNUmJ1RHN0bnNWelkwWFcxYmVDY3dP?=
 =?utf-8?B?OVdBR0FqVjlNTnhPUHp0SUFPcEptVVVUNlRYS2NVRHQvWWJ1NXNjVDh6U1NT?=
 =?utf-8?B?K2FDZzI2aTI5TXA5dXNUaDYvYThNaDZqeGF5bFZSRy9mamVnbWVNQ3dTT3RJ?=
 =?utf-8?B?c21NNVlUVlRNcTNmcVpKblpxMHZrTEExYlJXR0x1SnFwM2YyOEtMNVpzcFRR?=
 =?utf-8?Q?4JaabBVQR2z3Iif708AIMKe/O+Ffj8KXyOyz65VePXtp2?=
X-MS-Exchange-AntiSpam-MessageData-1: AbQY2YKsvQSw6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755d004e-10a7-4a7b-288b-08ded80aab10
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:22:26.6262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mX8xd7qiDqr1gZPccllGFPxZPQrxA6Rgu3fAM7MPZh11uNPeCJeWUnrthIE1eSlCIJycWOQuS4/gJyvI2lk1rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> Pass registration data to ioctl handlers via
> drm::Device<Registered>::registration_data_with(). The closure's HRTB
> ties the lifetime to the closure scope, and the pointer cast shortens it
> from 'static internally. The reference is valid for the duration of the
> drm_dev_enter/exit critical section held by RegistrationGuard.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

(Sashiko's report appears to be invalid - the HRTB is precisely what
prevents the behavior it claims is possible)
