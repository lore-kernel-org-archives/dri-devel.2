Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF1606A880
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YolNKwAf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1E310E218;
	Mon, 16 Nov 2026 07:41:25 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208E910E218
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzWA2FyXEqXNJKqPlIiIdii4sK3ZrOB5fo7D5L9DWMmJyCtTX8rsRJVbyUj1V2FmMR73tR6k7VxZg1XsMYrrUf1b/MnBw21bfWjDPb4OVYP9TgROWwi3PQYFWbHgpD/UiObZB3zPYoZdVEkPVbdOBVPB+t5+LeJJHKl+oWR7RmyHDFmdRbZJ9HCHQ8cmKGLrot6Ly3yx2Tv8S0A6acwcPXDFS5tN9sUqfX6d5dBb+8q4fXCGtQDn+YHFd22riS55DQpgNCg2s2QTP7NtAheHi+0zDD7/521NVSsVXHUz5AnOlyPy+UJvZ8Ae2BQI1XcLO/VLT8s2wZkdWbsSraC2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+LrmTd72zFIAfpf4ElzHhGmwkfe4EkEqYG+C++9+RU=;
 b=AO7+KZsxI3tp4Xk8p892sEyRYo3/BGceV2SOwWSilLwmgN7Aq+Jcdd6ez2w4iOrtCQuhuCAkjGAlnSvL+xC95HPXIj7DhCsFra9L4BP5aa9y6InoxTGf51CM/9A+KTGUUN2EIdgu+IFSjXRTf2/rrXsFfQMHLGDwlfoIG47SdNEFFzgMu6r+J2ajqrk+9GxOKm2GM88WrAeAEEHsNNzcjraUGtdEHfEs9EHdc6bdTn/qtg0I4D1Bm6y191BKopaf/xrcowBXFgCyj8PGu7hP0SnJQ5WEf2JgFEGlc6GZKu2kmRXhQraYbKPiMopBwyXxNUKvpN+EmC+ufLk8SnA5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+LrmTd72zFIAfpf4ElzHhGmwkfe4EkEqYG+C++9+RU=;
 b=YolNKwAfsBcx7wxDGaVad8ckgD5+QFqG8WU7Pinn2F/qfjFh+VsTWok0aIpbN19p1EIW8jq1obqzBVRUxjFYt04DigG0JtjMkgIZKyUGWOk/jB1KxX4HtwraeBwcG5PQwn/90WjKwhSKne1/+hBvVjS7/z+NHiBz8JtR1MS1cwUKlLaLDDk3QaZYHrzfvWZZenpzUIx5lIF6YZz3Ygr3smEh4dv3XUu9pAQaj+yWojy99QyvGIP1emALXgOFaBlvzb+39TtpMWqNFeLMbF5fYAVvzvyu+aXKuBD9L2k03xT2gI+mFudE8D74gvx3r5/UW7oqaj4EDlKCcdFK03WW8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS8PR12MB712524.namprd12.prod.outlook.com (2603:10b6:8:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 07:41:13 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 07:41:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 16:41:09 +0900
Message-Id: <DMWGRSF4RALG.3RFZEROU4AYOK@nvidia.com>
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] gpu: nova-core: minor NovaCoreApi cleanup
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20261111161935.750047-1-dakr@kernel.org>
In-Reply-To: <20261111161935.750047-1-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0110.jpnprd01.prod.outlook.com
 (2603:1096:604:258::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS8PR12MB712524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6636e529-fed3-42d2-742f-08df43b4fd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|22082099003|18002099003|11063799006|56012099006|10067099003|261028144727099003|261026140227099003|261022105027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: GZikN9ZWvA5jgm1ead3mL4e63391ZX1UbfhRKupv2nMoOJQO8YO8HJqRoV/fhZYYVOsnrLEZrDR4Cl2pN9JUR2WOhzcn4BzC28/ZuI4vF6deMCor0F8J0NP02R89cnzMWPFGsTR6PL3oadx7d9dD09fZHjraln52HKfLo25yIR80hQKUFF7UlN4OYBt8yXfhfIVhGo0vZJfJCFfrECwuQkEr/vhWDjbJqOhy5JmouScRADyyjqkLy2ZK+k4vLnrbD/p1aiW6uRUnQSzI0+4MQQlM2KwPCrnX2YMWlotHM52wuKONlKNfwzFQ20eJ7T6FhTdn90nqefpB4KJrUg67zJzTLhIgeMfcdDyC/Ho9kdU5HIpG4swLL06Qauzgt7hG0BOeu0gbkFtxSFa8A4QXDMKtdN9SVNsa6qsRKrKkL5BA/F0IyLSY6jdVdlFnwMq3EY4H5tygBphj8O3VN/6u2UekCBIC+OuDZe0L16D738gplmQuKlDuvBoE6ccRXJdK+dPkoF+5cCkjlSj0CCY8zUQwpFBqowizoTQOLaa1EYlxoyyhP5VhqSFp0Csw6+2SLzjDOj7hFiasxo+hFIXPmLdrnLINhQ9mMzl/2B+gHTbekoAroqlqjxvJgzLoItwE0bOhsGrjUbVJrar1WSeSEtiWh6jhckl/QpwW52m3Wcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVk1RFl5ZUszTWQ2YW0zWW1pckRkYWhCYStNWkZ6WTdJOUNPZ0NQZzMrLzNK?=
 =?utf-8?B?bW5TQmZVeHBMQWFXMVQ4MWVKeWYwbFFDUzBUT3o1N3FlQWxEbEFkUlZ5QnBh?=
 =?utf-8?B?VGZ3c1lMSzBBcVlFT0VoemtMbnp0Z25PWVpjLytJcjNMdUZUUjFYckJhZW1o?=
 =?utf-8?B?aDNQdGp0NVI0YXR6NUQ5aVNibmlWTUkwTUZyTHQvWDlvZ0NzSXZySnFIbEoy?=
 =?utf-8?B?VS9vUkoybUNxVDJMK2JTcTFFQ1U1TWR4SHJndi9ua2p1UEtZNGtveHBLcGxs?=
 =?utf-8?B?SXhMc2d6bTFrcVpoaER3MU9mU05iZWJ3a2QrWmMrbWpWMDl6cENuVVgrK0Za?=
 =?utf-8?B?ZWM3dVE3djlsMmgxdlMxZmFBSzZ4ZWxqa1lDM3lYNFlST0NWcTRPbWplTkd5?=
 =?utf-8?B?UFl4T0xvNVdUbXQ2NFBFMmY2UXA5eE5DT3ZNaFJlQ1NKNklyRzJ3VzFrMGt0?=
 =?utf-8?B?OVpxV0N0bkxsUEJlZGl5by9IUkxIOUkxS1RzRmJLMEpUak8yYXpnRmxORFdK?=
 =?utf-8?B?TWR5WllOYWoyZjMzUzJKUHRKa3JjT1J3YUp6NXA2U3ZLdXdzN3A0VUxwbER2?=
 =?utf-8?B?NXZEcnkrSzB3SVkrbnNBYmNZMTVuVFJmRWpNQkR2ZmhWbzR1UHRKZnFUUnp5?=
 =?utf-8?B?djFsWEtwMkxZay9JSFdYczZVWVJHL1ZtSkRTNXM1THFsdkZtNWhTRSsvMzVk?=
 =?utf-8?B?UEIyU0ZQV0dscktkZ0ZsSVJCRXVsdVpRSDZleXg5dEI0YUJ2dEJuLzJwenhR?=
 =?utf-8?B?dTVKMXNRM0o0ZnUza0pka3VML0xlUytxUVczN05aeEZZam1TQ1JHQ2dzcTFP?=
 =?utf-8?B?NEhlSm9nR093S1h0Q1JXdzhMaWQ4bWFoaktmTktMaksvVFdvcEFPallLQVhJ?=
 =?utf-8?B?QmsrRDlqME4xUEx4TXhmRXV0bUViR3FTZ3FJUU04MEhmVVpabHhBaUZCQXJ2?=
 =?utf-8?B?TnFZYk9KZ0NpaWd2cVBuS2gvZXdyRzRTUVpyaU9KQmxlRytoM1lMSDZ3T29Q?=
 =?utf-8?B?RTVwRllaZXVZakxzQUtTMjdrQW5BaGpJUUNkOEJTaDVmREtqZnMrWFBsbVlr?=
 =?utf-8?B?cUZGYXNoL3ZnZGtrQzNDUDB5TGt4VmJ2RGh6SGZtcFNzSTJEa25PTlJmZnlW?=
 =?utf-8?B?aE5BU052SlBvUVZKcWo5bHAwaHRUcWtyTkRHeThGcm9TdlBnOHU3WGJDNy9q?=
 =?utf-8?B?dm0rQ2V1TDhzWkFERXc2THc3MzlNUEFVMkRlRCt5anFuK0pNWjVOeEszNWht?=
 =?utf-8?B?SlpCSEd0M1NvTFNHRWZZY1dCdjNtdGlFS1Vha00yWWtuNk9QSndncEorc1hz?=
 =?utf-8?B?TXRQQXNMZzdDOUo3NFZPUFA0NjFwQ294N1ZPcnA5TmNJNjJiWlJoc1k2VzZ1?=
 =?utf-8?B?NkliNGs1dDA0ZGt1Z0REZ05UUllNVUxycHNobHdaNXJFa2JlbzVZdkd1TjUz?=
 =?utf-8?B?bE1MQnJGeDd1QmRUQktTZk4yZGxucTJ3V213enRscllTQkdOVnB6RnFrbEM1?=
 =?utf-8?B?Y0VhSFQyZkE3YVlJVmtrQUNpQldjUUlhTVk4Y0tIVWVFMEZXdDQrenlUZkFV?=
 =?utf-8?B?RmhWeC9tb1puaThzS2hVU2lRK2xLY2ZGcmcwWnNHY01rOXV4ajh6N0IvbWNK?=
 =?utf-8?B?Q1pHYVJhcHlBaWJFODFLYWJsT1F3RjlPL2tjL2lFdFkyK01UK2FjSThMOFBP?=
 =?utf-8?B?dkorN0JwWVo0WWp6L3RKazh6eXRJbk5nKzJmSW05SStyWTdweXZSaUxlYWRP?=
 =?utf-8?B?dUZCaGI0S2RxS2F3bkJiY3lVVVZRVjVPN2xLOFNpUE1mRlUyaEdLS21WdEdG?=
 =?utf-8?B?YkhTalNWQXZtOEJUWWR5cmJUeWkvNWpVVkM3RDY5UHJrcU96Q2x2VUFXUnBh?=
 =?utf-8?B?bVRrdW11QUh4dHQ3UW1rZGxYZE9IcW10UFpQdUZiNGxHU0t5dVpLUkFIQ3lF?=
 =?utf-8?B?QjZFVG5hTURPbjc3SXBFaWEvOThjUlVwT0I1dWxmMWxaWTc3OThyZnZlUC9L?=
 =?utf-8?B?bUl3emovOXptR05FWURocm8zK3RDWVlHY1IrN1FCc05oT2JOWEhsV0pHTzV4?=
 =?utf-8?B?Y0I3V2gzZ05wenVjU2RzQkNLY2E4bWFtMWplL1IyS3RxQ21ycFR6aW5neFFD?=
 =?utf-8?B?WVpZbmN5SjVZZStnSFQyaWNib2F0NFY0Lzk3c2ozN2NwYjBqRlg3eFlkRGZJ?=
 =?utf-8?B?d3RLSjZVQTJtVU5hWUtHMnFodEEwcTdPWEVoemNqN0o0OHFhY3FacVRZLy8w?=
 =?utf-8?B?bHBrVGNhOEY0VHNCSEVFaTgwcXlHU3FReDFROE8vdEVOMVNjS0pzV1lFSlNB?=
 =?utf-8?B?bFYwTmVFbG1nZVk1OTU1YTBMR1NEaEdHcU5KbGJxQTZuQzJJVjh4UUQyRSti?=
 =?utf-8?Q?nGGqjs0WGHFnxmcuiFzGGFGIrMoy84sGa6BZtAYyBffgL?=
X-MS-Exchange-AntiSpam-MessageData-1: QNC87dLJ1sat6A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6636e529-fed3-42d2-742f-08df43b4fd40
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 07:41:13.4170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSAgClxGp+SIF4v6CL360/ocvVT/63XnuL2+GmPQ1KRfg15+pSkCAc9305OYZeKNzEG3Fb1LG6jAfe9eo0KJng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR12MB712524
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 1:19 AM JST, Danilo Krummrich wrote:
> Add a constructor for NovaCoreApi and use it when registering the
> auxiliary device, allowing the gpu and pdev fields to become private.
>
> While at it,

... should technically have been a different patch; some lines now have
two changes occuring at the same time.

The logic is simple to follow though, so

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
