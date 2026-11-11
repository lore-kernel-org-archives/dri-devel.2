Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1B606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=Gl5zXYFn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F2710F9F8;
	Wed, 11 Nov 2026 09:22:21 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021093.outbound.protection.outlook.com [52.101.100.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB13410F9FE
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo2gM8BisZbFhSAaV53WTnjj1DvBHxrdebMKA14ALQ+eWQlW2Tq75SjsFOPHB+pvidergRMro0oxsAmwfzlwzEsOLQ0DHBedRJD/sgJWfv3+rrdG/C1MC9jbx/FBNTj0/12j6965b52xqfuAEr2BotXBn9gIMNBMR3bWP3V/KTTE6e2Qr/qwKxm4vuk/Jnuo3nsV3b103TF+s6aOjqvWFVihH1u2DiN2etXriGMY1mO4FXO3/1OZT406KD8r6yH31NwCm6TXq4VLcSLqMtevyHvrcmqDgg6dut4vmE4FWGGexyDTvJa1QDLPORtvY9/Dm0CCoLAbTfdpIsP5kvk/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib230lTI9VxO8MdyhYYsByHuDhGJMyISQBTXq3MK5y8=;
 b=ti91yERdMmaiAPKhj712ttILT1Z6h9N7jowYOlLKe4uzJheUG9B9F6FACOim0Plfg10sRY+QyPOsol91NZw5of9qx6XFi1SN8N8YVDwaxh8A9s2zHkdHkFmLbxri6AOpHfrpZn+8uB78uuHlVntEB/e4qnKqWVGs3d6yMGxzb/QrSOKw8VBsD4HXycNUjqxH73eZ2KvY9wAS7k3rIAfEh+9pIm1962CQuJ6a4MNRX4eSRk8LTx6/y0yXwaEW1KDnq4oVWN3L2ztQmZvNE6k3CigZEs2NshY5VXORP9gULra2tZVa41tf3rO19K/gU7OjcXfzLV0+mRaSa3XpzgXPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib230lTI9VxO8MdyhYYsByHuDhGJMyISQBTXq3MK5y8=;
 b=Gl5zXYFnLnCnwkZ5VoTe9AlZlDFMVkP9bAyAyKdG6PTVtEL5HjNY9rUmWRKkMvdupp7sM4CF1jYs+JdzcLFyf5nxxztlNWC1mB+J+1aJW4ryM45h/FfROdJbTPIXT5yHYK9e/dfuZ7B/n5wiAMuoMOF+rtpW34EqhU94hG2dFOM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6206.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:22:08 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:22:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 09:22:07 +0000
Message-Id: <DMS9SDC9CTFE.2GECEYQDWRHRK@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] rust: fs: add iminor() helper
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <brauner@kernel.org>,
 <lyude@redhat.com>, <j@jananu.net>, <alvin.sun@linux.dev>,
 <deborah.brouwer@collabora.com>, <laura.nao@collabora.com>,
 <beata.michalska@arm.com>
X-Mailer: aerc 0.22.0
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-5-dakr@kernel.org>
In-Reply-To: <20261107021427.2105374-5-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::20) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: d6eeca21-8a2a-4ba7-d0a1-08df3fd54252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|10070799003|1800799024|921020|4143699003|10067099003|56012099006|261021121427099003|261026121527099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hOYObkZEd4/X6ZOEIaT4Ntp+xHzF1+xStaMufCKMBWG8OLifhuCJDbfhBoETuhAAsfplap1g9tUZDDgoN6OBNH6T1DG4IzUNDxiuskMiRDyC8MzXr+y0VymSKB2d4p5L9WA2JofAmiLyyMrP0EWjtWRzsZHbMpgb6mrhfm5A8fS+3rjGPyaw6qrCecN9f/M0A7HwhILyQXmtYZtfRxshhdstxbzsya7RVmqS/bWjsgEAJGYGzv0Z+oF5CyAcnGMGLGnE1l0Eo0qurbcBeqEnYwQoOU0VJ19QvIzmHFrgqlCZKscu+bNgrHU7zkJyzQ61QhYO5bkU3H+OEkm/S8LHM5i6INghPOPFnnoZyYomMyRdRKiIxlaBW9qSsOeEYU/va8+HOQJnna/qttzsU6QMS3TSbQlbNSwfqoajuba71rkJawEMt3IPvJEqAiJCYyDiVpb/fno/TH5d6gg/r2p9nnyEEvv4lc+nQXNZnf0zvmAnBiuNqiIGhfCQ4cPnSIJZewisrMYI2m6kvOCKkyUGHg3EydQ3FAaYEZgRxchuwXs/uP56jM23XqmtOesciWQW4UT0TnO0iaGm9tlw4uaffZy1vJC79k8fL/GS1kM6A4GWRaAM8K2vnWgPBI6k1/EmVF4fo9uyFSMajJHdYSKLlfK7wrH1i0tWHEc7RasOtRyqgDDiEVqqg3p5E1tcDM0vaLrrDUEX0IIIeFxb2EwAhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(4143699003)(10067099003)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhLZS9PbENtYjlpVnAyNzNVMU5QNXEybURSbkY3bllPRTMwNmpTelFnbXk4?=
 =?utf-8?B?YW5sZGJWTjF2VEw1MG5EYnIyUnJUQjJ4c0RFQXpzOXpoMXZTOFArTUswQUVX?=
 =?utf-8?B?WFU0eWwzcWsrcjd4YUdOOHZvZHNVZ2I0dmo3a1AzR2l5cS80TmVpZC8wbmFk?=
 =?utf-8?B?SXVtQkp2MmI0enMvSi9XWWZIekVuVXR3Tm9NS3Vza2RxRzhCNGo5N2hIcW9M?=
 =?utf-8?B?Z0hieXVYVFZVSE81VjlTZFRRZm5DVEphYUhXWitVL0U2cHk0d0ZKWWNYaWpn?=
 =?utf-8?B?cmhtSEx3SnRPVGwzSUF1V3JhSm9jWjIwbGNKMnd6dHFUVUNBOWVhMDN2UVJo?=
 =?utf-8?B?clBZVUlBWGMzd0tUOGFDQktTWko3V2R5RHhDNXVJMjg0a3puOXRPMjBVOTl1?=
 =?utf-8?B?TVQ2dWtHWG40MHNlVXZmUHpPNG9DRjlEdHNVRFYyYU1ranBzRzBGc0U2ckFi?=
 =?utf-8?B?Z2tyQ05RTnlUb05QUisvSWZST09qS25CQVpsQVpQK2VMUDJEcjVVSi9iSk0x?=
 =?utf-8?B?M1hNSVhDaWdtY2p6T0tOalMvYnc2V3RGa1g5Q0E2aFJlTlczRHQ3Sk04U0lx?=
 =?utf-8?B?UnFCb1RBTmRQNDJONlFyRFh4L3diY1plVkdERDJoWFF6S3hNaCsrNDlMbFNz?=
 =?utf-8?B?cFhZa3ZLaVlXenExMVlQeTdGa0t0UmwyZmJ6RUZpcEJsSi91UnE4c3UxRFQw?=
 =?utf-8?B?d2NVVWJ5WUtINWZ1NnA1bGc1QmhMMGJubEhzUnh4V09HU2pmVFB5dURYTHI4?=
 =?utf-8?B?MWtETkhnSFlRY3R2dnl5K1VSSFhYT3ZwdWpxNzAvQ0Q5S3Z6a2Vsb0hrN29V?=
 =?utf-8?B?Q1F4QU9Ud3E2cTUzWmtHcUdFRUFTZDExS0JDaHNJYVEvUTNTQ2hlbXBjY1hY?=
 =?utf-8?B?bHA2cWRGK2N1L1RCZmViTjNWbGcvWWk1RVYrcUVUL0t1aG5FOVB3YUNZU2Zk?=
 =?utf-8?B?L1YvSFkvWTBDQ0dCUUh2YlU0MjJ0WGRrejlMUGxqTUhWUWhwbkpiQ1YyQi8z?=
 =?utf-8?B?Qkg4RkJ1a1JzeUI0WDlpM1VZL3pKZkEzczUvdURWL3JOTGpvSU5sL0dTK3pZ?=
 =?utf-8?B?ZGpteUcvRkRrSDVvNTI2M1RYM25SeU5jQjYzR0NvYkhkbUZDU2Roc3ZuaWFo?=
 =?utf-8?B?anhMWTE2eFhoMVZQcGNtL3lnc0hxTys1V1lXVEZtSTI1eE9uQmFvbU1ZdUds?=
 =?utf-8?B?SXdDRjc4QWprKzBWSGRGQUp3ZVhTYmwxYVYzM0Q3VWdqV0xCRklXVnNkeUZZ?=
 =?utf-8?B?a1B3dXlSS04vRDQwcW1uWWo3L0FldTgvTTZpWEx2MmQ5dXIzUHhlRG5MQTBt?=
 =?utf-8?B?Y1J4SHZ3cFRwRUhOMSt4YXdOTHdOZEdDaVl5Q2c3cUhpbjdMaklnbHJEWjFW?=
 =?utf-8?B?Nm95YmVNYytlTEthTW9XT0lnZ0EzeVNXSGpoTW9uYVR6ejRGSTAwZzJTcWxs?=
 =?utf-8?B?RHBoVXJGQ0RmOW84K05SWUNPYVpIRC9UZmd0ZzlSa3oxcWs4TnI2dTlVeUt3?=
 =?utf-8?B?SkhFbUVDZVVKVFpNNkxuaStIMHVLNzZtbm95VXZSQjVBOTFpelVKRzB5ZTJM?=
 =?utf-8?B?U0pPL0xBWmI1S2hTdnpPMllYWk5OVlpxYnRRcys4QjJIZXVKZ3VzMXNINEIz?=
 =?utf-8?B?Y2dtdkpJOWNkbDZYNnZlSURna0FoUHYweHF5aVd1dHFvb3YyOEcrV2VINzJE?=
 =?utf-8?B?ZVdsVkhyWG9SV3NaZWh1WkpiRWxTL3ErYWtZUmVXUGZ5V0lzS3pXcEVNUnB1?=
 =?utf-8?B?dFJhWTV2WmJnMVRRK05vcFRsRWs5SHlCWHlMZVh2bzROSk43TmF5YlFFZWIx?=
 =?utf-8?B?VUoybFphaTFnZlY2dlN3YlhHYkY5TG5aTURSa29ZTFdkTE84clNQWlJwTGVV?=
 =?utf-8?B?VG15VnpUb2ZtRStYUllpRnM3MVJHcElvZ2UvWUtaalUzWVJtcWVFQ0pyekF3?=
 =?utf-8?B?UFh2blo5NVE0SVp5NnQ0cWx5Ny9rRjN6c2EwSDJVaEZUYWJkdjNDRG80QWRw?=
 =?utf-8?B?OW5XcUlCRE55eFBCQTg1aWhrMWticUZyY0J0aVB6UEoyNFNwSWJGSnZiaUVq?=
 =?utf-8?B?eUhUa0JlbnRTWGIzbUpHUmJJZGNZVDdPalZaTWhqcWZWVDd4RkxkMG8wR1Ev?=
 =?utf-8?B?bW1aVk8ya2NiMklsTHRydi9hb3grNEZzTVk4bTRnenJLNDJwelVuM05wakkr?=
 =?utf-8?B?bHQ1Q01zSFhEbElqa2VaTERCWFM0T25PdWVCMS9VSWttV3BZMGdFQ1I5T3Fo?=
 =?utf-8?B?UHI1bXRCaWpzcGZVdjl3UXNBU2VOc25NWkdmZUM0SU44TmtWc0l3bHlLaHN1?=
 =?utf-8?B?L3ZCeUdYd0xtUFFTUTJVQ0pwYngxN3VpcHIyVVRla3ZvaHdxcWFmdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d6eeca21-8a2a-4ba7-d0a1-08df3fd54252
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:22:08.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBjo6lgV+zFL02MytM2gZzKef1vteU/58C56giOkVScLg0hA5J2tEZjetWYp5dXMwcJ8XInYKC5a2gvdtPRcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6206
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 7, 2026 at 2:03 AM GMT, Danilo Krummrich wrote:
> Add a Rust helper for iminor(), which extracts the minor number from a
> struct inode. This is a static inline function in the C headers, so
> bindgen does not generate a binding for it.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/fs.c | 5 +++++
>  1 file changed, 5 insertions(+)

