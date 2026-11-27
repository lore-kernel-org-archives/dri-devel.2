Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6F606A326
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=hLMlwcWl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 277DC10E83B;
	Fri, 27 Nov 2026 18:59:49 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C73910E83B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlETAytEU+B04TV4PuXGhQUSAe2HUBytt/tZOKb4zdVpsBmRGNmX383A9+cTY43H+XpJUlAxPqqA2PpWwgrFim4GvexNNNMyOdUhsbf6QHfGMR0ah0PVvQaO9BNv7Y0QKcTmhy9Nf+VkBZZ05OLSzrZIQVB4L0pnJdYTJN1rbk1TG7mXfZ0dPtDQkz2P8E/vBQqCS3HUTrjvQIKpRF9JPbuZl5+IccxgJlewfXsatLjju6/+t3dXBqNW/lfE+tveQpJW7sVqdjufD1Vpl9kINOIBoNxw+Sc+Bhty8zK6+eGFYW2vPv+ZbgdBdC/7JIjYFAZ/RjLs4i3QRWKb0DRbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm1CEMmc6wrRAocfz4AHDIX7fw1XlFAa+8Y+WYNOkUc=;
 b=IM0eqidN7wiccn2XlcHicH8iESwMP/tirkrHcMXrDj3BO/Y897vPx78NtECzvOxY0BBDcxBqawEsFhGeoczpG80BnXmzQiDN+5Q55XavakqpvIfyT9VJoeON6zOvDSQ5LzhLFWmd35zmmhV5yZ/NTF6GY005Z/cdz5R8okzDSyvtakm5CqCV1TA2/mrvALPX8K1ftCBCEwHCWQJ6oWFdG/JGggHneBDea1rSbtcz+2Bimokx5UGu29rXARpWjQ2l7y1e5TNK3vqggZkg6vQHGUHwNYhKD93Dfzyn09XNv9owJm7VESRG4Q3CNiq3lL13DmjMUeu3zjkXC6qlbvFFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm1CEMmc6wrRAocfz4AHDIX7fw1XlFAa+8Y+WYNOkUc=;
 b=hLMlwcWlOG1gUk2XaPQ6h3VvYygRGpaIUkjfMJovE4QLpCQZICP/LKolsWOmtQuyYV/j8CzKMFvFPToZXAsWIqn9nByUf7yMh1AX8/h/JlYLpU1vyqEZ0T9Gafmji/+jA7aw5e3C7FAj38mH0Jzc3mO5gFDwVO/fcxQJP45Qa+M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB6241.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 18:59:38 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 18:59:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 18:59:37 +0000
Message-Id: <DN6838W1WF2T.2FLQ4AOZX5B40@garyguo.net>
Cc: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rust: dma_buf: add dma-fence signalling sections
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Philipp Stanner" <phasta@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
In-Reply-To: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
X-ClientProxiedBy: LO4P123CA0611.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::10) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 0552ed27-3273-48ae-bce3-08df4cb895b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|23010399003|261009223027099003|22082099003|18002099003|921020|10067099003|56012099006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261022115727099003|261021130227099003|261022105027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: q8L8enzbVqnjmBScYUWlHxdty6xcLu7FZvTRpb687iJzzDpferh/Bfq+qB5tX1ffPneLYD6ASjgKu15AEegqjZx5AjP+EInISFQM+5OKKoky+LBU9RgNNlGb0Uji+Quclx0mBcnX+jffhDu591ogTRykHkLlswreNIUuXBEHSHYg/c21J2jdqVDRzY9+8FqPF0W15FboqdmZXzACPgEBonCfAN4jKE1fG1t+ebfCidOo63eM0xkVdvxv6wmfwX1sRYraHDEkiO5YCcSMFotCyVfVZNPdWY8NJhPgU1NiQPTLGbvgrSSzIpKWwR2ZWuDKNrp9aES5QGknnDTZm8eqbRXW8ESJZunU0rdwZnYWbb8Tkxory2eywZ6NQ0X49UE3+RlkjeQjEhVUovGug5U7hhbP0aZYch14SNnF/xDSVS+wp2vAS48ia3s43+IhGHE7O7crf3xaFI4p33LlJBPnGO9dNEnT8x2jyDFgwNiGRGSDSbGO0E3viuNEwLLUkfytp/NPbUgJD3XO+6efZIW3UYYkJCQem3Cuzt7PwsJ906ZZ/XtSQlK83UBH6jCdjovaAzinwMdhuBOwFVxrQ0EUqayLwbMTo1E2CkRFlihiOtz9fQWomWAMzKJzCw6dsQewvvbCFkQ3mfQnMbi30DkezQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(23010399003)(261009223027099003)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022115727099003)(261021130227099003)(261022105027099003)(261022113327099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0xYNnN4RmdxMk9ZODlnemRrWEV0RnIxVmNkN3BQY1hGRXJiZmlKNjBwNks0?=
 =?utf-8?B?OXhyM0RXWXZEUEZqdlFJMlNscm0xTDFVWUtVdVpHbXQ0aHYxQzR2U2tEL2hQ?=
 =?utf-8?B?aHVOcFdlRmtDbjdHU1psOWFLYkpMVTMvR0lUQUs0aEllRW5ZSitIN2pkZjU3?=
 =?utf-8?B?QkpXNktNcFFWMDVSM3ArVGdHS3U5YTdudDM2UURUN01ndHdYZzFqdnpNbmxs?=
 =?utf-8?B?UWU3TktWOHVibFlHVi9JTG5hUEZpVWovU2VXNG4rcHJoSlhoRFN4M0xOTUxr?=
 =?utf-8?B?dUJNZWovVU8yOFZGdjU3bWRQcXBMbGJINk1QNG1xamJUQm01bGpXNzhFeUhV?=
 =?utf-8?B?dzR6dWVDVlA2UlFwOXZQM1Y1b1N0ZnIwaW5ZcVB5K3dwRHVuVDE3UGxUbjhG?=
 =?utf-8?B?RmFnTGlpYzdscXU2bklEWFBPdyt1c1c0RDBXQnBLQ0swVDh5VkVlRVJEbi9l?=
 =?utf-8?B?ME5aSkhQZWZ1VUNkbVhNcHdmeVRGTzJHZWU3eVZwL3dnRHQrZDk3WkREdHlG?=
 =?utf-8?B?NndqUG1qdmpGZm1zY2YrUUpiTUYyOUN3M3FPR29aUXdTMDNzTmJqbkkyRnVx?=
 =?utf-8?B?Y1V4dHNob3FOK2VmRjFJWHp4QlBRUGxWV1AyZS9td2p3UkQ4aVBJd2pXS29y?=
 =?utf-8?B?Vys3a0owSHo0S1RVN0hBWTJjRGNWNDhyM2J6eXh3UkdRK0g2djc1UWdXNDVV?=
 =?utf-8?B?QVF2c3FGMUlGYUVrRXl5SEJWQThMdXN1Q3poNGdQWC9KWi9QalhSMGM3bmNS?=
 =?utf-8?B?enlxYzM0bkxxelNNWEJFVVhaWElIeXFzaDN0KzFZcW1zMURxU25aZ2ZMOUxp?=
 =?utf-8?B?bStYVFhFeTdsT09QaUtKTVJBWDZwNCtkMUlCeXNsL1hxWm85T0haeURyZ0J4?=
 =?utf-8?B?cTNzcVdTREt6KzE0cFpQd01qNWVic2kvSkFqTnlMcVhkakthZG4vb00wazE1?=
 =?utf-8?B?elFyZURsOHFZQ3hsWDdieEIrQUZhNVNjSHJ5d0FhalZpT29SUW1NK29qQTEx?=
 =?utf-8?B?V29vdEk0UWJMRTcxTlMyVlN4ZDFFTHZWSjBZYW83bml5NHpaQ1R1bXE5SDRi?=
 =?utf-8?B?Y0JESGY4TDFWaVoyL1FBa3RxdnBYempoVDM5dmxTYUZKSXl6RkUxakxoL2Vq?=
 =?utf-8?B?YkU5cVVtd1B0STJ1NTZzaU1HcDVoR2YrVWZjK285bDNYN3pTRHZqVUFIemZK?=
 =?utf-8?B?SlFicnRSbjl3bE1JOE41VkJxT2d2Q0laaG8xODA4alhPUmRVYzlYNEFGMWxJ?=
 =?utf-8?B?TVBtK1RhZ0RHQ0t5T0puYjhCeDF0YkVsOVdYTWRVRUdha3ZBU200clc5cldy?=
 =?utf-8?B?c2RuR1RnaDNONWVJenVDSTViTDRnSEg2QjFZV0QxcU5GS3dtT2toZE5WTGxZ?=
 =?utf-8?B?emhuMURzb21FclNQb0JQRjlqcTFKZE55UWxsNWNheFp6dG5XU0lOeVpuc2JM?=
 =?utf-8?B?ZUd6YmN1Vm9ib293WUxjUWx1UHlMZi8xUUcrbHNhQ3hCTmVhNUhlNXZidkNP?=
 =?utf-8?B?RmFSeGFEQ1pXK3drb2JIMnV3UC82bHVZRFhnMkdCUW93b0RPK2VSVGl1Y2sy?=
 =?utf-8?B?NzBoNVNDTTkwQVhneE8wZERwd2FERDZneFRSL3laNG5PZjBhVHpLdDRsWk4z?=
 =?utf-8?B?K09ueVRLMDUyRkIwTzVNUklWTUx5T2h1UHBTNk5HaFlYN1U2Ri9md3hmOWlW?=
 =?utf-8?B?YlFqYVZZSXZYVURVNklmM1h2R0F0SFgxcWNPZjhEdlhGclFIRzc2MFZnVGJu?=
 =?utf-8?B?aUJxbDB2UlQ4NzVxM0thM3dJYWE2MEpsUEpINTZyWjlXSTJGUjl4d2F6ZHF6?=
 =?utf-8?B?QTUrL3doVlQ2clBMQU1wQ3lyUGFnV29ESGFVWDVtQWYvWlpXeFQ4S1IwL3lu?=
 =?utf-8?B?Q0tHYk9VTXdqaEpHMUZIM1F2dG8wZ0d3U05zUjI4aWVsR0U5UEtsaDFWYVoz?=
 =?utf-8?B?dlQwV3k3bHdrTXAzUy82L052MVVnTmNZVU5YU2lPTTExUmN0NUZHd2pyNnhJ?=
 =?utf-8?B?WklJM0E1WkVmdEQwVUxzTTk0cXJTcE5MMHR5MmVFRTk2NnlWNG5MNVRVOWt6?=
 =?utf-8?B?QUFFeDBqbmRSZHQwSkVlVWNsQlAxaUVVRHRCcHVXQS9LdC9vU0orQkQvV1Zq?=
 =?utf-8?B?V1lSUVQrVWNzVXhCZlQ4dzhtWkt3T0pyUkhFa282dVp0OFJtUXIvS0srR1Rr?=
 =?utf-8?B?akNtNWxEU0xQK0xkYkkwQVRzTzlRZjFRLzJJTTVmQ1ZaNEx2WEI2WTBaeTJB?=
 =?utf-8?B?VVBFSTY2STMxZnR6UWt0Y2kxNUh5K0tPSVBHNmFGYnhIUnZsc05QRzRrNnBi?=
 =?utf-8?B?U293YWlJNlFRVnhMcU1iOTJYL3duTmUyM2R1dmtrbG40WWF2anZ0L1FyS1pO?=
 =?utf-8?Q?vbmzfMylgAZ+W/CMkSF9+CzMiJH34g2g8+Pcp?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0552ed27-3273-48ae-bce3-08df4cb895b5
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:59:38.0648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmNEUUrVH8vIV4R8TMU+l/zZZZjbQe5db1T3aA7EanOG4o/lfNVr/cFMxp+tyqGYqzuE9fysi7aGaocDrs06kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6241
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 27, 2026 at 6:30 PM GMT, Daniel Almeida wrote:
> dma_fence_begin_signalling() and dma_fence_end_signalling() mark the
> code that the completion of a dma-fence depends on, so that lockdep can
> check it against the dma-fence rules. However, up until now, it was not
> possible to use the signalling tokens from Rust. Thus, add support for
> it.
>
> Patch 1 adds SignallingSection, a guard that begins a section when it
> is created and ends it when it is dropped. Patch 2 makes
> DriverFence::signal() take a &SignallingSection, so that its callers
> have to be in one.

Do you need it being a guard? You can do things like

    let a =3D SignallingSection::begin();
    let b =3D SignallingSection::begin();
    drop(a);
    drop(b);

to break nesting. A closure-based approach wouldn't have this issue.

Best,
Gary

>
> Patch 5 of the JobQueue series [1] changes the same signature to
> signal(&self, res). I will rebase on top of it once it lands and add
> the section to its callers then.
>
> A follow-up series adds a workqueue whose work items run in a
> signalling section. Tyr will use both.
>
> This is based on drm-rust-next.
>
> [1] https://lore.kernel.org/r/20261124122951.878199-2-phasta@kernel.org
>
> ---
> Daniel Almeida (2):
>       rust: dma_buf: dma_fence: add SignallingSection
>       rust: dma_buf: dma_fence: require a SignallingSection in signal()
>
>  rust/kernel/dma_buf/dma_fence.rs | 77 ++++++++++++++++++++++++++++++++++=
++++--
>  rust/kernel/dma_buf/mod.rs       |  3 +-
>  2 files changed, 76 insertions(+), 4 deletions(-)
> ---
> base-commit: abfb640b2374e26de8ff81d488c39d8254db538e
> change-id: 20261127-dma-fence-signalling-cae3def9aa97
>
> Best regards,
> -- =20
> Daniel Almeida <daniel.almeida@collabora.com>


