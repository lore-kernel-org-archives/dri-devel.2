Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3DBC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3299410E084;
	Wed, 29 Jul 2026 18:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="iWjgQq5W";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022097.outbound.protection.outlook.com [52.101.96.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B0010E084
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npq9uT1rb1Vgs+ghsXamHrTILt81PhjxtoSkmeo7ymOSWOtTLYBbtZ9IdCH2SeYTNqIoSEVVPxrE/bG0SAw/KF/ynDRyRVsVOFUsawE/QS8EOWEbnk0sXyCynKuo1z8xCaIhG+oEnl7GnvT1cc1oWFkdf+GC3Qs9hzBTQozZTFlFGm0qOYHEJXm+4XQBOAuAYRoeaftr0mmtisV5Tjjui9HesVgitTKmUn4I0b2IHyGsanKFXVNhED1khz2+lPDdcZr+5f2T3EkL59bmdRXU/AyCoTCyYoswQgS6kpCZ+170cWNuQPUYJ1JeeByrnKJ4KHWr/C/lI+NAXU2m/GUKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu+uHmUP7kZo/sRlTsh4r5GE3nXPmGh5eVcgXyZ0ZmI=;
 b=DgyLP/sb3kPCECvZDlrSRK9xGTAIBIi8nnPxbFMxdyOohY7OMwUuAD5XUp9CDefMLcWjpeClmDiZUBwC412VUz9ObPg6jVKAQP/YNutfdoQmxqUR9C5Clhly5zxzBfSiP9kmIs/TOPTuQXWjrzm9J9c/1TfdYJI0re4pfkTXJ/pJzgQg6Tzv2Ty8lcKROKVUYwfaqXrdcz3HQ91vjHLtqqyW0SQOCISpS0cewNnOJqH57YUuqtdh943OS3yZvc6LAjLp5C/yLzwmErzV2l6R9e3WNIrQbd15udmu7lZQ22qFUvJG+c092N9eoIiY/J8lPqP5jkWLhtF/A/gEQfJP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu+uHmUP7kZo/sRlTsh4r5GE3nXPmGh5eVcgXyZ0ZmI=;
 b=iWjgQq5WX3E8NCPzqXpe0eZSi+Xr7wshanvojwMCsDEm7i+KzBVwExQepgpYiNMAyYuT4uh5nh9luZm1RDUyuJDb+kTIldJKx347tFr4HrSms8+wb3JgxSZB2RpWLaCoLvU9OvzsPcSVvGEufigURI+q5d/oZmPOgyJu5Q5Tmow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7766.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 18:47:48 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 18:47:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 19:47:46 +0100
Message-Id: <DKBA29HOEUIX.H4CDPOQQXRD0@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Lyude Paul" <lyude@redhat.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Asahi Lina"
 <lina+kernel@asahilina.net>, "Burak Emir" <bqe@google.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Mirko Adzic"
 <adzicmirko97@gmail.com>, "Timur Tabi" <ttabi@nvidia.com>, "Daniel del
 Castillo" <delcastillodelarosadaniel@gmail.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <rcu@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] rust: sync: Add abstraction for rcu_barrier()
From: "Gary Guo" <gary@garyguo.net>
To: <paulmck@kernel.org>, "Philipp Stanner" <phasta@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260729094542.302965-2-phasta@kernel.org>
 <20260729094542.302965-5-phasta@kernel.org>
 <296c71c4-4d2f-416d-bfbe-40fd911b44db@paulmck-laptop>
In-Reply-To: <296c71c4-4d2f-416d-bfbe-40fd911b44db@paulmck-laptop>
X-ClientProxiedBy: LO2P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: c2637ef5-b49a-4c33-35e0-08deeda1e268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|6133799003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: j/asv5XhjFCAWXDbG80BzrUU+SeuuFlL7+0fapyflFLvnAmHiHD1M9/QYNKv7BfKtERRlN/UaUJSyLMhyyOVpxFs5iIySOgUtWombBr5ShB8u8/o4lqMJQBqui+eDelbnwak+DMwT/wjf0To6nEWQ2e35ssvijQXj7hK1QAd+L0u+r9khB3tQhUCpyMm4TSggJU2nf5xQZ3wSPyq3BAgW1BAO7aOvaDrq/oJ/aEa8DmTh4u7PWRlQbekfbiRMl78mfDkMTPZZshdyLxbGcJFQsGN2314ZAreI2ZxtAyayfBatsFBFdN/THMQRj/QkQUQfWLhKygLnqhm7NHFH9fA+H7VyXIhKvWiN83m43tvpCj7EfzIcZ9rezu+a0sFGhjDlJv0LBDwydXqQIBom3J1xx3OwJmnLWB9qOU7hzjGTtsKXeBg6X8nXoNN0xdVW61mNENNU6IOiYch8h8/EHJgrjJ9KrdUFosPCUL9Swi6DXkN4tJYdzltHlMSndegI0DNkLT5YU7Ek7cIqV4w26H3Spdypc8J4mcTX0VhGLjf2He/YKYDsrWHrjuZFAcizMwDy1b/tj9SgGKzi0DkToR2MfKF4c1yao8bUBEtczso9f7fGyGE2N99rxJH7gw/u/C/ly68tjCHmrr4DEcgcTpAU97HItq0DAOlIPog3CVfQHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitwMlZmZzlMS3hkVDM1OURjVENkbk55Q0EzdCtUdVJqT09UK0FMbTJHMWp1?=
 =?utf-8?B?dXB6bmFxZjRQcjRPanJoQjV2ci9FZ2wyMTZ4bHZPQUxXS0o3SDM2TnZrcFFZ?=
 =?utf-8?B?OGE3cDQrVGlRSFcrRVlubU1VQlYvQm0xRFRLMUJDV0xBRElScVc2aFBlU2Zi?=
 =?utf-8?B?MXJGdHluck42NmhQaTVPUCtxK2pkMU83OHJZcEMyWi9kNUpiU2tiSHI2blJn?=
 =?utf-8?B?RW1rWDAxQ00yZURXR1U5L0owY3B6dkEwTis1elI0bUROcUNYbDFZckU3c0FD?=
 =?utf-8?B?SjFyODJPSFB4WksvdSs5cWg1UGpINTZCY282Y2U2TUNRbDRWWC9NblhETXpp?=
 =?utf-8?B?cE9xYUI0azRDTmVxNWdPdEkvL0ozdHNIMFhtY1dvNzVRU0M5blZSNGhpZUR1?=
 =?utf-8?B?dmdBdFErWGlmQnptdkgxeHJZWjNCZnozYnVIQ0ZrUDZ5WW4zeTdlKzkxc1FB?=
 =?utf-8?B?RmFoOEpVUVREWUZXV2lER3BPWDVCUFAvR0VTejhJS2JCOXpBZ3o4K2FqcDA5?=
 =?utf-8?B?UEEvT0tlald2Z1BNMmpZS2tPVGY0RlJrSndGaEl0R2RJRmE4OXZ0dHNOMGF3?=
 =?utf-8?B?cS9NL0ZaaURkRHFWd3hid292R0ovUlIwRGNtSTZKaWprWEZKSGVHWUtMQ043?=
 =?utf-8?B?RmNlUEhFRUxPT3RSTldHTlhHYUNCY3J3MzNCU0g4WXFBa05pOTdFTGlmOUN2?=
 =?utf-8?B?Skc0enNCVWtzbXR0WWtNU0ZZOFJzRGlLSW1TUS9TekZ4NGF0Z28yRC83bUVG?=
 =?utf-8?B?ZWhFOUF3cW5YbTVJbDJ1S0M5bFMzRnJUYWxZbkxFSVRkUXVuVHcrdHU4YmJh?=
 =?utf-8?B?czA5U2cweXZXOWpndGZaZXBZUkk5cG9uRmJlWk5YcU5sWEprZ1BBQnFzcVRj?=
 =?utf-8?B?Y3FuUUlmUkZGa1B5OFNwQnNRZW8wNW5IcjJ2QWRIdklDZkF6bGMxTGhrdU81?=
 =?utf-8?B?RG5rUUZFVGw0Wkc1WHMvUUlYMmVabFV2cmlNWnMwRE1oQW1EQjJjSUM0eXVB?=
 =?utf-8?B?NjJ6S0lMYXFUQllyQjJSQWYvZEN1bnJRK3hmVkVFci9tWHpsaERXemdiVURE?=
 =?utf-8?B?ckhTa1NNbnd3cFZvUDNDQ1BVcUdLZnhTTXpFb2VaUTlsczRXK2gxNzE5bkdu?=
 =?utf-8?B?MkV6V0FheWhCZVVwYUJwUjFJR3VkcmRIc0xodUxSOFNUL2dwR0hhRWRwUHQ4?=
 =?utf-8?B?bHBmUFVYaFBYTHNnOVFCNWtVYzk2QXVyc3M1TUJmcndoL1h4dGkrR1hhMlFP?=
 =?utf-8?B?QXBQOFcwcWNYaFJKalZzMWwzdHE5eXVYYzQ1VVZzMmdhN3BPcllwZzJxK1RZ?=
 =?utf-8?B?ejBpeUFldWF5NmdjK05hb0JIblhvTjlSY08rZElpWUowb3IyZ3JHWVFQbWlJ?=
 =?utf-8?B?TTBscll5clhsb0RMNzJVZHNqQkdCUFc5UUszd0xXUitKZXJYSUdldnZWM1Zo?=
 =?utf-8?B?emh6RGFGZnNwVGZSZk9rdjZabHJNK2hKSitXWlBWbE5HN2MrcGVxdWV4azY2?=
 =?utf-8?B?bkE2cGszRk1TeEx0UUhFRWpPaDVwQWRINTh6d2tvUFFqTk05TXh5MXNZVGVI?=
 =?utf-8?B?Rms5Q3hkbXJ3Unh4azNvTm1HaG5kRU0vM0R6cTNyM2tHV2krckNmUnN2U2I2?=
 =?utf-8?B?bjFNemwrNitCVGxQaGszV24wQ2p0elQ5VFdRckxMTE1ESFIySWxUR1cyZE5z?=
 =?utf-8?B?OENNbUczVGJPSEhLRlU3MDlCVUFHdFNCOW1SK09BMGMwZWxLenJ3VW1DNVdi?=
 =?utf-8?B?c0V1RldsVGw5czlUcVp3dVluZTFnalpVMncxaFN0OEVtSmY0T1FMUUFDdDhN?=
 =?utf-8?B?OVU0ekczL3FyVkxqQmQyczFOYUlKUW5XZGNHOHRwa1RiOHFsMUIwYmNxbWN0?=
 =?utf-8?B?dEUzVmxXSFpDNmpaaGNIRHhrVUUySDNlWFd0eDltSjRCZWhMd3YvMUhYUjNC?=
 =?utf-8?B?THprYkFkR3dXNDRzcmVMajJseEJxbDI4Kys2aHNlYUxrVkdzQnBzZ1BaRDV3?=
 =?utf-8?B?RWtBVmhtVmZIaEZJanMrendlcC9XakNuZHBlc2h4N0NPbWo1S1N3V2JpeUJu?=
 =?utf-8?B?Uk95cmh2dS9OK3hoU0c4K0J4Y0dpMHFmYzVTbTRZbmk3RnNIWTZpUFF5TnhN?=
 =?utf-8?B?YTMrQVNqVW9tSWgyTlZhc1ZBVzBydUYwU0swcDZMWndhd2ZLRHFsSXB6WjFo?=
 =?utf-8?B?dGc3Q2dlQ1FZdnRwZHdJeTBIdkliazRjR2Y4N01INlFlaTdBVGdsSjIxVUZi?=
 =?utf-8?B?YzVrUkNrd2RkL3duY0ZXYmJNalA4Zy9sUkF4N2NRQ2JqRmpIY25qMGEzZ28v?=
 =?utf-8?B?Zmp5RSs2Sm5WWDJYM1RGTEZ2Vzd0ckdobm93OFdzbnArT01RQUZTQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c2637ef5-b49a-4c33-35e0-08deeda1e268
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 18:47:47.8058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33re0y3Jb8hqd8iXfq7GUzs5A+i2JACQ7qCVMlCNxP1UNAlSfucXNZtiRXpm2Y6YS0IDxUysqSOqLyI3V1OKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7766
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

On Wed Jul 29, 2026 at 6:18 PM BST, Paul E. McKenney wrote:
> On Wed, Jul 29, 2026 at 11:45:40AM +0200, Philipp Stanner wrote:
>> rcu_barrier() is a frequently used C function which is always safe to be
>> called.
>
> Just checking...  Here "always safe" means only from task level, with BH,
> preemption, and interrupts all enabled, correct?
>
> In contrast, if you do this:
>
> 	preempt_disable();
> 	rcu_barrier();
> 	preempt_enable();
>
> the results won't be safe.

This is same for all sleepable functions. In order to avoid having to mark =
all
sleeping function unsafe, we've decided that sleeping from non-preemptable
context is "safe", but is a bug regardless.

Best,
Gary

