Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85724C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A4E10EEF8;
	Wed,  1 Jul 2026 11:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmgLopFi";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 814AB10EEF8
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi4z08A8A9gkcYLyCaijGKhdlgwGB9PorrYp7GUV+zLuc/n4BC72qjHYSlHnoi99NXb/dCdtVCZRe3mVVxKfDtkRmKGYca95p3M8rl683cRgQVP+FpZ0qe93sDaUYb1HWAO4PuNEJsQYguOBdt/NU+zVQRvnVpSn/n7KLlAcoNYLIYMuykCZ+RuFON9Zu8bNwnpJdZz7GjqpV7hDA1Z3Yb7JQ87Wkz2FBzoRM+sUebpwHqWQWfjGxQidy4MmxbQjwDX9Kwecqdl5qbKkcQk8EyHhzJu7IJ70ZarsWv7pVTzlhMWWj65iaF13RKRJeG74MWoJySg3Dv6tNUw+r+Xf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qut/8/buukTgFxBR/0qOsVc3PWZ/ybQK5y36DRU7pm4=;
 b=qyxxzfEnar+MR6vG2//I/jT4ax4bEzwBtbH+v1mfDYjstAFl03pQE+zFmY1e5bZAbLh2zns9Z6AILmluph+BK26YJ3q/4jvi9fSY9E5f1hgs7DaSD3yIKL7fIO1RLKFL+6p392I01vNDTskSlDbH28Ux92pcoNhjK/bVGQ34dr7UUE5+fwYkDAO+QdsK+Ood7w90g/n6otnvtxl/LAanVC8rkEBubNAkJzjbveLWC4zAg8rmbFbIJnfvUUPhBG8xX3Eg5HczikYSrTPaHV8OFZKKSpC2E9wt7SWWagGuBPNTZALaLGiccdpBq/NFRGkddRRa6TOTiYQ0z6AqSazlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qut/8/buukTgFxBR/0qOsVc3PWZ/ybQK5y36DRU7pm4=;
 b=jmgLopFi+GkvbL9LFr+PcW/Dbs0tisAc3tEGgq6azCE6T67CCLcT1FIiAD2EKhhk9jAtUrCdtLgRAYb4soaCmtEg4l78JfY+2n0ig4ztQAtnq0UCjtktOeeP7OYljpO4y4m/p+/FD5Ej36HSC4tigPMfI6Dxq8crndBXW2ecyefjvxWyzninoDdpNh9QyqwltHIbfllCV4DdMhbfNVAbF8NUppxsgoPjhVxFGb/5VsnSkvF+QwNtwg2++dQdekNvAsFadtRoECKR5Hsrvq/I5nKnkz+a6OWJ4QlsPeWdFFs0DERjJpwvttfMk2DPuBu1YQNVdrKLL/tJ9J8WYiAh/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 11:30:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 11:30:00 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 20:29:56 +0900
Message-Id: <DJN77RU2Y70X.2H74VN10ZPXKO@nvidia.com>
Subject: Re: [PATCH v5 02/19] rust: drm: rename Uninit DeviceContext to Normal
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-3-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-3-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:604:254::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f0e96a-4502-4295-5c71-08ded764163d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: zaD9sc+O5ReOqL3bhlmutepxOXuOe+KKH6sMg456nr9U1xWHdnegwcNSACFJKdz3rU8qvReI0/hoU2ObhKPRDlSOGAwTcpHQv6YJKzr8J8dGgZ6Mn8+UkSvb4QSsHKm1+wJObX9DhMKrkcAugM+Oz7oM4QumHYIE3FIGcgcaQmcHXeyPV4EyFDO7optKb0/0VXV+2nnhW8zqDThuPwrx+pDxO2RK8RRb5QMYt6ncXTpWWENbYaFQZYzphQ5jof9eHeJ+T3H0v19MiFNF1+yZexUwomL4QUQg67ZFPeyT+PLBOtSEL9qwCyRcVMJxF/zykyJod5t6hA6Vmg3m1GL26EjNLCBm6WqGMN96jJUxdu09U5uVFv/c+5aozaHyKM0Si4AGrGjHocCDk/Dh+qtbe1SSgnnvCSMx9FN7MnRB3ZjLPwaz9W++2oGITpL/c/0GaK9xYsImRfivus0WLgeBVmdDmUOWw7uh3MPKhwq/fPG3rFNPuI1YNj0UhavPSCgwdMS/iApXL+8i5HI64EkFR7bmSmZJI552dUnxsf32I5frHU98v5TWflydtOwYkfOAvMBK6OekkiXTOXPPfseIE1Ip3yMB1xUiZMV/6E8R/xN9D3yaMjrtMqD97ZfvuFyKsMt5yD/TOHnirg0dd/x0P8CEpiQbagaxm9ImxbBe9VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N042alNUQ01JMTUyNmlBNVZYSU9iZXpUcVFHcjhQcHdabll4RE9kMGVvc1RC?=
 =?utf-8?B?YklrblBNVStiVUZwbXhnWGtlcUQ4T3loaUlyU29Nd3NkZjFWM1MwR3o0RjZw?=
 =?utf-8?B?SGZJdmIxU3YyaXpVdVRlZ3JwemNwVkZKTURQdlZHYjdyTDJocDdrdWRuazhx?=
 =?utf-8?B?VXg0ZDJFYlBISlc4ZDkybkxRTVlIejZNellCbndVSW5jUnU3Zk9RNm42UUtr?=
 =?utf-8?B?ZytyUzE2SUh5Y0JaYmNNNWw4ZjEreThPa0poQ0FFRThKYjUrWXh5L3NCTSsx?=
 =?utf-8?B?OEVOUEExZVZVTTZqdVFPWmt0ZTlnZEx1QVBzWE1aRjV4aXVObmlUcnpVbW1S?=
 =?utf-8?B?QU9DMVZCeHRUcEIxZU9jUHo3RHVQeDhBTlI4OWNMRWFaQkdjYlBTbjVHejll?=
 =?utf-8?B?emRrUkxCSE9SeVkrNmNId3Fleno4KzkrK0Ftam9Oem9wZHc1a3FJbXN6aXFv?=
 =?utf-8?B?MWxTM2s0YkF0UTNveEptUVdJdWxmL2NBOU9rMDd2amdoeFhLK1BUelRza0tP?=
 =?utf-8?B?YUF3amNUNFJ6OGE4NUViWkhVNUJFTGYrL3QxWU16SFRnU3JEMUVJYkIrWmc5?=
 =?utf-8?B?cWtSaGN5QW5kOXBDZ1VZL1BDcGZESVBjNm5DMlVqRWVyQjU5UVB1djdPMnor?=
 =?utf-8?B?ZURaVHlTR01YdEhHa0w0OEl4QjdFWFpvNGJQL0RHb3dWYlk1TEFTTWJOQkRU?=
 =?utf-8?B?MkhvSnRUWlhvY3dHdXN2a3U5eWtFb0VXUW1XRHZnOGJVdDRLZVZVL1RCN0Nh?=
 =?utf-8?B?czk1TEp1SUd5OGlwVG5SR3J2Z1J1SURhTHVTdlN2ZEJBT2FVVEJISnJSQXdy?=
 =?utf-8?B?cEdKYUp5ekpHVEE3anZkQllGbXVpM2ZIaHZxa1VxRVVBNFhYZ0hZQ0xnVDlj?=
 =?utf-8?B?djlsVUVSK3RoMTRWTEtQM3FsMzlVN1RyOXFPL0lwa2kwWStvVXdDMGpkSlM1?=
 =?utf-8?B?T1ZKVnYrNkUzMjZyditITVo1ZXpZSXZwTXZBYnplNlpEYWJNTUZ2VzRpMHUv?=
 =?utf-8?B?ZHJLdkw2cE5Vdk9WUXRsd2JzekttNi9NcmtYOUR5cXZNOWtvY3FqZUpkaGh4?=
 =?utf-8?B?Sk10dXF6bERxT3JtUlZDZVhQc2xvYStmbjFlYU1hbHJ6U3N4d0NKRlhqWGZo?=
 =?utf-8?B?WFVKU1VQYWVYcDJGYlMxb3o3ZnhOMEY5YzBjL1hJdERYWEF1MEFhR2JwVm9k?=
 =?utf-8?B?anRxckRXRTJMNFlaSnlNaEZ4bExpcUpWelhWREhIdVhueDg1ZGdXZ2lxYWpn?=
 =?utf-8?B?Z0pIcHlJL25BNUhEaXRyd3UxNmkwQXVpOHloNHp2c2J0dkpZMk1mcThuWW1m?=
 =?utf-8?B?aU1JRWVGZkNNRWlwSUJnaGpSTU5HMW1rNDR5UlRRcjYybjE2K3o0elpXcXRV?=
 =?utf-8?B?WXkzc0l1bThlZS84eHFhNFhubGUxb1FPVzgwSld1QVdIUm9teGZVQXNHMWpj?=
 =?utf-8?B?ZFVrbmoxSm9Lakp3TmI4N0JvTnhLWTByQ1VtRllVVGpySGN0QUpRWmkzTXVi?=
 =?utf-8?B?MitpRmViNEZQUlpHN3N3K3RCV040ZEJOTlFlMmRpbWw3ZjNCQmszbGxTU1VK?=
 =?utf-8?B?bnZRQnRvRmlIMFdVTWVCWXJDeEdPYmlZZFl0TU01M3UzbnRvZEo2dFBKbnRM?=
 =?utf-8?B?RGFTM01tQWhLUDc5WEl3U0ppVHl1VElub0YvRTFoL2VIVEo0d0FIQ1dpQlJy?=
 =?utf-8?B?Y0hMNUYzdXNRQllaUDhqVkFMQWsrTW45VGQ5N1d4djZMV2o4NjdDSFNBclpz?=
 =?utf-8?B?SENUdnRIQkpjVVlyRnRaZnNsemFZK2g5T1VITUlpM1lDSHh2SjQwdHBIYXd2?=
 =?utf-8?B?emIwVysyZkpPTHlUZ0EwSkxvd2pBTnNLTEo3SmVGaW1zM0ZFWlprOGsvME1z?=
 =?utf-8?B?NjUwdDBhQ1lZQlR4cTZkcGpWOE9HSU9tYWt2bkxyTG5QUG12dHFXWElMYVZs?=
 =?utf-8?B?L3JiUWJiY01xeXZiMVFRNVBCMXM3cEZhUTVrUWU2NFBhMXhKMGFIMWJld29R?=
 =?utf-8?B?bmYxcHR3bVA5cGdXSmQ1ek9QbitjaVhZa2Q2eGZCYVFmZ2JxN1R1VkdYVWc4?=
 =?utf-8?B?SVhEaG5kWkl3VnpSakxKWGE0dG9lcCthVjFaYUlxaUkzS0owMW9HWUxEYXUv?=
 =?utf-8?B?dzNEeXBQWXh5eWVkL1hTaVR1TzBrOEtvcEpmSVR5TjBrcmhpRVNFd3VPdjRY?=
 =?utf-8?B?RHZHcUxYdm5DQVZzdmFlZ3NxQ1pvemZoMEh4S1hWTThCaE5qVklEYWJUbDlN?=
 =?utf-8?B?UzhjekhqT1BNN00ydnJFaHVoc01kTlA2cmtwVjNGeFNHRDhVcXRjU3k3bTRX?=
 =?utf-8?B?QXpMQ3RIQ2xmY2YyL3pnZm15R0JCSTljWHFRSG14K0o1NTBFdmFoWjUwQkpq?=
 =?utf-8?Q?18qGcYIdSMmGwQSn0Z+vvvWYioSFjt4St1DNAu2Ux/aKI?=
X-MS-Exchange-AntiSpam-MessageData-1: cq6dSUvpU3Bb6A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f0e96a-4502-4295-5c71-08ded764163d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:30:00.4651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ose+aRNMkSV5MYAC4giJV6X0xdR2140YnFXUUmO7T/lDL+C/rxf9ZJhbH9/B8J9L+63bAGmMC7QAV1ohAa4AFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997
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
> Rename the Uninit DeviceContext to Normal to better reflect its purpose
> as the general-purpose, reference-counted device context. The Uninit
> name was a leftover from when DRM device private data initialization was
> planned to split across UnregisteredDevice::new() and
> Registration::new(); with the subsequent introduction of
> RegistrationData, this distinction is no longer needed.
>
> This also simplifies the DeviceContext documentation, trimming the
> multi-stage initialization description that no longer applies.
> Subsequent patches will refine the semantics of the Registered context
> accordingly.
>
> No functional change.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
