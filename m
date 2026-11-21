Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2C606A336
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=tOekQoUW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8990D10E8A2;
	Sat, 21 Nov 2026 16:21:35 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E22B10E67D
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xk9CpTBgu0A0m02FYmly2UaEWrRK860fZL1B2g8MDA6H6Hq0rfJA9LhOHp4JCK1rqTrEKDWG/zqhXNsaKOGMP/jR8nTbQGPHXtDk/ETBLC2u3seDvryaQfdltUV/gjQ87z7I7BvrUa6t3ywgcWeRLYXWmkGJYqKXdeGN2loW44RnwDoNuhcnInctrT2LchdLvIbm+C0bTV5vZQNq3BNRK8H2ZJKbHI7IaSUKo35JlZmB/nWJM2IJPb3sKG1k8dq74U3Ig7YoAN1fmn4GHGvNqN7/GPi1Qxpa90EVoUuTphJq0H0OmouKZOCLqYXB/A1FktZbaI9FnPi7bXjwJRtV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dgZrX/ONPpTNnU2gY3gUDgB1y+t01Qd6kyZx3+qQQE=;
 b=ifwmDduxMUjRdAdIx4bKju0LEoQb3BXIkNhGdDJJJxz3CENXtpgDddu3wO4sncA1Pu1LL8YYNzYNReo2hKp1BfC8lSKakOy72jsrwqqhhK8qzi4ksoM/CLpW+GI62MU5RqxizaYgue5ZgnFf+SnnfSz6CWVpV1rvG5vhDrZPd885enrnelU+m6HPSdy1PeVp786RsgbEN0+cVJ0BdiKeE21eQrExBXcLm9a3bwyGtKVQgvkFvefntRLcMQPIUqg5Zx9A4JpMMFzTb1MqrgeViTuN/qB4EkGfpsVD/yIHp5xxmOeXVFDWv3WN7lDTpDR3sMqAlRsW4EhPigQbU/ebqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dgZrX/ONPpTNnU2gY3gUDgB1y+t01Qd6kyZx3+qQQE=;
 b=tOekQoUW8eE6s+jmWrkysx2bR8Wj6I19OnK2/ucK9GmY8sI+2CnuA71Y8qtmI1kTIWwnbB77YvzF+PJP2I9EX8yKGDkVbHytKj94QKeGxhBgG1aYcanPsunaoFqUnQUFxVZ6xXPJC4H8ViNPTLOBSQPvEqN1J6RDdfObWR7x0Hc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6428.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 16:21:24 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 16:21:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Nov 2026 16:21:23 +0000
Message-Id: <DN10YTXVVM7I.1IMQ5ARVQDCMK@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/3] rust: uaccess: add method to get UserPtr from u64
From: "Gary Guo" <gary@garyguo.net>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
 <20261020-b4-dev_query_fixes-v4-2-df66b4c98bc6@collabora.com>
In-Reply-To: <20261020-b4-dev_query_fixes-v4-2-df66b4c98bc6@collabora.com>
X-ClientProxiedBy: LO4P265CA0298.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::8) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 304532fa-1ad5-4903-5c9b-08df47eb7c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261102123227099003|261021121427099003|921020|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kcpeRpVpdv+Tq2f1xMzN9IFmSRF+YYusg3qQdwZVBR23dMjuowo8kRDN2nLRx8idPND8zFIHt0lh9FIlaT0Pvel93BnN4OhIT0Yybro40Ee9XoSNyJHtD8vultXw4ExdsynzLjcrTu9y97SBPuXpxoDntrXGgTTO4ltj+90tGshWELbm2dSnp9QzX6Y5UxGcb2vNWsFTAlfE/3BfK+ERSYKspMzoSuxLw1IaHIYz9KZqCmF1gPtsNE11Eiqw68TVcSqyFmufuXafHoT7HcGRdiLi7qrXeZM92Nk6EJbWqLitUJj33UCCygQ7z55nr0FVHNyHvHhb9g7yRH2pASGF4IVoU/CRHouP9C9Ku8Fg8SMSAb9/6UP0YckKHGt/wJBMqS8746AFcf6PQVR0zacDLQj0flgkvA7B/q61HezS1x7AK4tE8POZEACMxZ7ONgSxL4Nr5jm+dvLCSDHnAadECclAeYOo79xYeGBTBgX93DhDXYpukhTf9VAMPL4eGYsmH58HAqdxMNIrwmP4ooavHrLsjR6kWk/7CdTc/4nEZtelxAP/xEB5nTmzyfRAqZpGOGONnW5OohABH0iJSGMuaeMmKDAVDfQRBNUO75BWHbq1+r/gplgpmbrUIXc2m5Y8hl7nDZfRAo+K+vgCDfEAimgGF4U4487hqKo8vif8hyL1nG3TOAd5XxZ8Vq/fu+JmXRcbTW7T0EHpxp8AzEGTzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261021121427099003)(921020)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUg2YWRsYnpwQk9XTk5IditjZzFwN3ZrRWtwSmVPV2l3OHhkRTZlOUl0T1Vi?=
 =?utf-8?B?L3R0UEVHaDNnaFRTeWZUMm5EeS9JdXNuYXZlZjdUMGViakZGQk1UWFY1MGF4?=
 =?utf-8?B?U3BjckJ1MExVaHdWMGVWbG80LzB1MU93bjBNTzh0WFhoczF1TmFwUzFac3Q2?=
 =?utf-8?B?ZUM4YXJhS1ZacUZScjVSaFE4bjRRd2E4dVc1ZEJKeVMzekk1SUx3LzE0SzJG?=
 =?utf-8?B?ek9yN0NQWmRrbU9zb2tmNCtvK292WWNsUFJvbVJOZXRGOW1GaDJwUUYrSmVL?=
 =?utf-8?B?dEVnYjdLcCtpZHlqV1lYZ3loQ1l6c1IwUExJUndMcVNMUlF2QTJ3NzQvbkhP?=
 =?utf-8?B?SVlpY3BodEhRQ2twRlY2aGZkNjI4T1dWWmxKaHg4UUVRVStMWFh4OXZKMlB5?=
 =?utf-8?B?T1A2UWQ1bVpiL0x6TEF6RGlDQ25qditqTVN0R2YxcFRRVk1lODZFUEJqYkE5?=
 =?utf-8?B?RlpkWkRNQW1mbFVmcHlhVnFyN3BpQkNXWFFqdVhwNDBPOGlxREhSWUJEUFRS?=
 =?utf-8?B?bUpPdGdiVENFRDZzZGV6TmY4WGgxelFyNTNRckkxdlRqOUpMNU1SWUMrTGc1?=
 =?utf-8?B?ejlyanAzSGF6S3RsVzZ2UUw3bXZpQjA5aWJWNW0waVRJSG96SEJBK2NxdDVi?=
 =?utf-8?B?ME50bmtzaE5QaDdVRzlvTTByYnNwekFoK3hhcFdZS3hMOU1ZMy9qZytSQ3ll?=
 =?utf-8?B?bDg5Y1BlNzd5TldTS3A1ZzdHMWtLS3ZLNy9ISzlrQ0F6WXdpZkdINm00TDA4?=
 =?utf-8?B?TGtXN29xdlpreEd6a2pKOERFYXJjRktJSEZVZmtvdWt5YTkyOHZJYVBESDFi?=
 =?utf-8?B?akpoRlpWeW1RMWxZNXhSVzlNWmI3ZVdPVWx4R3VZQU5RN29NcGt3T3Q4cGhm?=
 =?utf-8?B?aFpUUWoxREpMc0pIYTZZVFhOTk5lVE42elBxb090YXJnc1BZYllHb2lKRTc3?=
 =?utf-8?B?WlpyMkdiTUJDeHhjNE1TSVVPdWZPUTZMSXBTMkZ6a0NydFdQVlVRamt3L2JE?=
 =?utf-8?B?MHREZk1tUExHSTE1Y0xHTXdaZG5WbloyRE9SZTQzYlloVUlhSmpVbVlxYUEy?=
 =?utf-8?B?azlsRms3RjVZRW9ZK3ZDa0VTTW9ia0NTK1lYNGk0dEJ6aXZsUGgvbzB6SEtM?=
 =?utf-8?B?ZnA2dXJEeGZhK2Vjb3NzQUkvYWVoYjFvSWtjY0FlZzhHM2VZVlNLRjVXNWVM?=
 =?utf-8?B?Uk0zU2FMVWJiTy80dTJNRGNPQUM3SGROZitjUEF5Tm5tRVpqWllSM1l6VXNa?=
 =?utf-8?B?RFQ0TGdjY2VKdHY3WElDZGF2YkgzSmxzVXFEaElTZjVUN2ZJaHBUUTR2K2Fv?=
 =?utf-8?B?alY3YU13U3VOcVBmcWJtZERCSC83aEYzaHQwMTBUcEVDYmt6K01yYWtkMVRw?=
 =?utf-8?B?U0phbmtCTUt6K2hoZlEySFkrc2s3cE43QWt6M2dycXkxZ1JmVDlzc2tNTWFv?=
 =?utf-8?B?OTU0NEMyZHE3MzJtaDZlMFUvZjlQV0RLNWJSdEZlMGFLLzF3dUtUdDBTRGNh?=
 =?utf-8?B?TTFYWll3bE9SQTZEbkkvRVBFdVpiZ09oL2xSTjZBbXdhekplSVNxZWtKZ25N?=
 =?utf-8?B?Y3VYRTJxRGd3YXorNHpEUVl2TUliMVR6T083WE9tOE9jUi9PU0lRWWVxVTNq?=
 =?utf-8?B?U2hHeUF5WldpUjQ5bWJRNm1rQ2RRRDVIU2hsQ2tIYXBCZ0MrMVgveVpCM3F1?=
 =?utf-8?B?NTdVdG5TWGdPMjYwMnRkMW1vOU5QS2JmSVpxd04walRhd09lK1dPL2o5Y1Iz?=
 =?utf-8?B?Wll1cjNmOGNvemtvODB6UlB4dytqZTJMbnZLanJocGNqK0pGSlo2VXp2S013?=
 =?utf-8?B?ekptcTUvbEtoMFUzVU9QUGVXdE9BdEwxbStNVy9pby9Ob1dCeUtxK0V0d1hr?=
 =?utf-8?B?ZmZVNnZacmRxbklpMzNvSGhoSUhjbkl4RGVVUndWWXUxK21lVTBJU29qSWNE?=
 =?utf-8?B?czNZczRhL2ZGQUZUV1pZVHJQUHJzcWRRaVdDZUdaR2plM0x3Skp4VzROdERT?=
 =?utf-8?B?VHpUUXEzUXJqYVFGV1poSVVTR3ptQXlITjRxVDhnS3dlNkl2cExBOGZwVW1t?=
 =?utf-8?B?NC9rVGJENHdqa2MxbHdjZ284bEdMMElxWGV6aXQvaDJYNGhhNlhFdDBicFIx?=
 =?utf-8?B?cHhNR29WUUcvMmdJaGpuN2dYbFRydGZDOVN4NDRIUlplT1hqRFZiRGJwN1N3?=
 =?utf-8?B?WFhQOUJZNG9ZVHRDMU9FaHp3cS9BZkF6SVBpbHpMdXl6QjhvT2Y3cStFcEFN?=
 =?utf-8?B?cWRnUjlQaHB5MU8rT1RUaXpKWFJyMmF3NHd5aDVZWUJmM2JEV2N6cHdTWGRp?=
 =?utf-8?B?MnZTdjlWY2ZON3N1ajd3a2czMWVpOXY4T1hLdSs3dnphZEpPNFJtUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 304532fa-1ad5-4903-5c9b-08df47eb7c8c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 16:21:24.3613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXfARtt/uJ59fH7QGEZWXhRvs9HgOgF0Xv+v6iAJ9IR8XMC4UGg6u+WkgyU/YKyiL7o7Ecid/Wi6RLYBq4rmVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6428
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

On Wed Oct 21, 2026 at 1:06 AM BST, Deborah Brouwer wrote:
> Currently a UserPtr can be created from a usize integer representing a
> userspace address. To create a UserPtr from a u64 integer, the u64 must
> be cast to usize. On 32-bit systems, this cast will discard the upper 32
> bits of the address.
>=20
> Provide a new method to create a UserPtr from a u64 integer. This avoids
> the caller having to cast before creating a UserPtr and also clarifies
> that the truncation is intended. This is equivalent to the C-side
> macro u64_to_user_ptr() that provides typechecking and casting to a __use=
r
> pointer.
>=20
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/uaccess.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)

